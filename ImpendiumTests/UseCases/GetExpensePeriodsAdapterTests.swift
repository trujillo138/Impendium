//
//  GetExpensePeriodsAdapterTests.swift
//  ImpendiumTests
//
//  Created by Tomas Trujillo on 2020-02-17.
//  Copyright © 2020 Tomas Trujillo. All rights reserved.
//

import XCTest
import Combine
@testable import Impendium

class GetExpensePeriodsAdapterTests: XCTestCase {
  typealias `Self` = GetExpensePeriodsAdapterTests
  
  static let firstPeriod: ExpensePeriod = {
    var period = ExpensePeriod(date: Date(), currency: .canadianDollar)
    period.expenses = [
      Expense(expenseType: .food, amount: 10, currency: .canadianDollar, name: "MockedExpense", date: Date())
    ]
    return period
  }()
  static let secondPeriod: ExpensePeriod = {
    var period = ExpensePeriod(date: Date().dateByAdding(years: 0, months: -1, days: 0), currency: .canadianDollar)
    period.expenses = [
      Expense(expenseType: .food, amount: 20, currency: .canadianDollar, name: "MockedExpense", date: Date())
    ]
    return period
  }()
  static let mockedExpenses: [ExpensePeriod] = {
    return [
      firstPeriod,
      secondPeriod
    ]
  }()
  
  var sut: GetExpensePeriodsAdapter!
  var expensesStorage: MockExpensesStorage!
  var cancellable: AnyCancellable!
  var storagePublisher: PassthroughSubject<[ExpensePeriod], Never>!
  
  override func setUp() {
    super.setUp()
    storagePublisher = PassthroughSubject<[ExpensePeriod], Never>()
    expensesStorage = MockExpensesStorage()
    expensesStorage.mockExpensesPublisher.mockOutcome(storagePublisher.eraseToAnyPublisher())
    let dependencies = GetExpensePeriodsAdapter.Dependencies(expensesStorage: expensesStorage)
    sut = GetExpensePeriodsAdapter(dependencies: dependencies)
  }
  
  override func tearDown() {
    cancellable = nil
    expensesStorage = nil
    storagePublisher = nil
    sut = nil
    super.tearDown()
  }
  
  func test_Execute_PassesStoragePublisher() {
    // Given
    var periods: [ExpensePeriod] = []
    let expensesExpectation = expectation(description: "Expense periods expectations")
    cancellable = sut.execute().sink { expenses in
      periods = expenses
      if expenses.count > 0 {
        expensesExpectation.fulfill()
      }
    }
    
    // When
    storagePublisher.send(Self.mockedExpenses)
    
    // Then
    wait(for: [expensesExpectation], timeout: 1.0)
    if periods.count == 2 {
      let firstPeriod = periods[0]
      let secondPeriod = periods[1]
      XCTAssertEqual(firstPeriod.name, Self.firstPeriod.name)
      XCTAssertEqual(secondPeriod.name, Self.secondPeriod.name)
      XCTAssertEqual(firstPeriod.idExpensePeriod, Self.firstPeriod.idExpensePeriod)
      XCTAssertEqual(secondPeriod.idExpensePeriod, Self.secondPeriod.idExpensePeriod)
    } else {
      XCTFail("Expense periods view model has not been assigned")
    }
  }
}
