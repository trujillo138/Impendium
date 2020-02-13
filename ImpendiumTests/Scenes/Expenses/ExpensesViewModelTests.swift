//
//  ExpensesViewModelTests.swift
//  ImpendiumTests
//
//  Created by Tomas Trujillo on 2020-02-05.
//  Copyright © 2020 Tomas Trujillo. All rights reserved.
//

import XCTest
import Combine
@testable import Impendium

class ExpensesViewModelTests: XCTestCase {
  typealias `Self` = ExpensesViewModelTests
  
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
  var sut: ExpensesViewModel!
  var getExpensePeriods: MockGetExpensePeriods!
  var periodsViewModel: [ExpensePeriodViewModel]!
  var cancellable: AnyCancellable!
  
  override func setUp() {
    super.setUp()
    periodsViewModel = []
    getExpensePeriods = MockGetExpensePeriods()
    let dependencies = ExpensesViewModel.Dependencies(getExpensePeriods: getExpensePeriods)
    sut = ExpensesViewModel(dependencies: dependencies)
  }
  
  override func tearDown() {
    getExpensePeriods = nil
    cancellable = nil
    periodsViewModel = nil
    sut = nil
    super.tearDown()
  }
  
  func test_GetPeriods_PassesStoredPeriods() {
    // Given
    let expensesExpectation = expectation(description: "Expense periods expectations")
    cancellable = sut.$expenses.sink { expenses in
      self.periodsViewModel = expenses
      if expenses.count > 0 {
        expensesExpectation.fulfill()
      }
    }

    // When
    getExpensePeriods.mockedExpensesPublisher.send(Self.mockedExpenses)
    
    // Then
    wait(for: [expensesExpectation], timeout: 1.0)
    XCTAssertTrue(getExpensePeriods.didCallExecute, "Missing call to get expense periods")
    if periodsViewModel.count == 2 {
      let firstViewModel = periodsViewModel[0]
      let secondViewModel = periodsViewModel[1]
      XCTAssertEqual(firstViewModel.name, Self.firstPeriod.name)
      XCTAssertEqual(secondViewModel.name, Self.secondPeriod.name)
      XCTAssertEqual(firstViewModel.total, Self.firstPeriod.formattedAmountSpentWithCurrency)
      XCTAssertEqual(secondViewModel.total, Self.secondPeriod.formattedAmountSpentWithCurrency)
    } else {
      XCTFail("Expense periods view model has not been assigned")
    }
  }
}
