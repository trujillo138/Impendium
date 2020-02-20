//
//  MockAddExpensePeriodAdapterTests.swift
//  ImpendiumTests
//
//  Created by Tomas Trujillo on 2020-02-17.
//  Copyright © 2020 Tomas Trujillo. All rights reserved.
//

import XCTest
@testable import Impendium

class AddExpensePeriodAdapterTests: XCTestCase {
  typealias `Self` = AddExpensePeriodAdapterTests
  static let mockedUser: User = {
    var user = User()
    user.currentCurrency = .euros
    return user
  }()
  
  var sut: AddExpensePeriodAdapter!
  var expensesStorage: MockExpensesStorage!
  
  override func setUp() {
    super.setUp()
    expensesStorage = MockExpensesStorage()
    expensesStorage.mockUser.mockOutcome(Self.mockedUser)
    let dependencies = AddExpensePeriodAdapter.Dependencies(expensesStorage: expensesStorage)
    sut = AddExpensePeriodAdapter(dependencies: dependencies)
  }
  
  override func tearDown() {
    expensesStorage = nil
    sut = nil
    super.tearDown()
  }
  
  func test_ViewModelWithDate_Execute_AddPeriodWithDate() {
    // Given
    let expectedDate = Date()
    
    // When
    sut.execute(date: expectedDate)
    
    // Then
    XCTAssertNotNil(expensesStorage.mockUser.lastInvocation, "Must get user from storage")
    if let period = expensesStorage.mockAddPeriod.lastInvocation as? ExpensePeriod {
      XCTAssertEqual(period.date, expectedDate)
      XCTAssertEqual(period.amountSpent, 0)
      XCTAssertEqual(period.currency, Self.mockedUser.currentCurrency)
      XCTAssertTrue(period.expenses.isEmpty)
    } else {
      XCTFail("Missing call to add period to storage")
    }
  }
}
