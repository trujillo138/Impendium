//
//  IsDateValidForNewPeriodAdapterTests.swift
//  ImpendiumTests
//
//  Created by Tomas Trujillo on 2020-02-17.
//  Copyright © 2020 Tomas Trujillo. All rights reserved.
//

import XCTest
@testable import Impendium

class IsDateValidForNewPeriodAdapterTests: XCTestCase {
  typealias `Self` = IsDateValidForNewPeriodAdapterTests
  static let previousExpenses: [ExpensePeriod] = [
    ExpensePeriod(date: Date(), currency: .canadianDollar),
    ExpensePeriod(date: Date().dateByAdding(years: 0, months: -1, days: 0), currency: .canadianDollar),
    ExpensePeriod(date: Date().dateByAdding(years: 0, months: -2, days: 0), currency: .canadianDollar),
    ExpensePeriod(date: Date().dateByAdding(years: 0, months: -3, days: 0), currency: .canadianDollar)
  ]
  
  var sut: IsDateValidForNewPeriodAdapter!
  var expensesStorage: MockExpensesStorage!
  
  override func setUp() {
    super.setUp()
    expensesStorage = MockExpensesStorage()
    expensesStorage.mockPeriods.mockOutcome(Self.previousExpenses)
    let dependencies = IsDateValidForNewPeriodAdapter.Dependencies(expensesStorage: expensesStorage)
    sut = IsDateValidForNewPeriodAdapter(dependencies: dependencies)
  }
  
  override func tearDown() {
    expensesStorage = nil
    sut = nil
    super.tearDown()
  }
  
  func test_AddingPeriodWithRepeatedDate_Execute_ReturnsFalse() {
    // Given
    let newDate = Date().dateByAdding(years: 0, months: -1, days: 0)
    
    // When
    let isValid = sut.execute(date: newDate)
    
    // Then
    XCTAssertFalse(isValid)
    XCTAssertNotNil(expensesStorage.mockPeriods.lastInvocation)
  }
  
  func test_AddingPeriodWithNewDate_Execute_ReturnsTrue() {
    // Given
    let newDate = Date().dateByAdding(years: 0, months: -5, days: 0)
    
    // When
    let isValid = sut.execute(date: newDate)
    
    // Then
    XCTAssertTrue(isValid)
    XCTAssertNotNil(expensesStorage.mockPeriods.lastInvocation)
  }
}
