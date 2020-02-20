//
//  AddPreviousExpenseViewModelTests.swift
//  ImpendiumTests
//
//  Created by Tomas Trujillo on 2020-02-19.
//  Copyright © 2020 Tomas Trujillo. All rights reserved.
//

import XCTest
@testable import Impendium

class AddPreviousExpenseViewModelTests: XCTestCase {
  
  var sut: AddPreviousExpenseViewModel!
  var isDateValid: MockIsDateValidForNewPeriod!
  var addPeriod: MockAddExpensePeriod!
  
  override func setUp() {
    super.setUp()
    isDateValid = MockIsDateValidForNewPeriod()
    addPeriod = MockAddExpensePeriod()
    let dependencies = AddPreviousExpenseViewModel.Dependencies(isDateValid: isDateValid, addExpensePeriod: addPeriod)
    sut = AddPreviousExpenseViewModel(dependencies: dependencies)
  }
  
  override func tearDown() {
    isDateValid = nil
    addPeriod = nil
    sut = nil
    super.tearDown()
  }
  
  func test_DateInvalid_DoesntAddExpensePeriod() {
    // Given
    isDateValid.mockExecute.mockOutcome(false)
    let expectedDate = Date().dateByAdding(years: 0, months: -1, days: 0)
    
    // When
    let outcome = sut.isDateValidForNewExpensePeriod(date: expectedDate)
    
    // Then
    XCTAssertFalse(outcome)
    if let date = isDateValid.mockExecute.lastInvocation as? Date {
      XCTAssertEqual(date, expectedDate)
    } else {
      XCTFail("Missing call to validate date")
    }
    XCTAssertNil(addPeriod.mockExecute.lastInvocation, "Shouldn't add a period with an invalid date")
  }
  
  func test_DateValid_AddExpensePeriod() {
    // Given
    isDateValid.mockExecute.mockOutcome(true)
    let expectedDate = Date().dateByAdding(years: 0, months: -1, days: 0)
    
    // When
    let outcome = sut.isDateValidForNewExpensePeriod(date: expectedDate)
    
    // Then
    XCTAssertTrue(outcome)
    if let date = addPeriod.mockExecute.lastInvocation as? Date {
      XCTAssertEqual(date, expectedDate)
    } else {
      XCTFail("Missing call to add expense period")
    }
  }
}
