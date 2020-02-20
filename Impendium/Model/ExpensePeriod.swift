//
//  ExpensePeriod.swift
//  MyExpenses
//
//  Created by Tomas Trujillo on 5/22/17.
//  Copyright © 2017 TOMApps. All rights reserved.
//

import Foundation

enum ExpensePeriodSortOption: String {
  case amount
  case type
  case date
  case name
}

enum ExpensePeriodFilterOption: String {
  case type
  case date
  case amount
}

struct ExpensePeriod {
  var expenses: [Expense]
  var date: Date
  var currency: Currency
  var month: Int { return date.month() }
  var year: Int { return date.year() }
  var amountSpent: Double {
    return expenses.reduce(0, { x, y in
      x + y.amount
    })
  }
  var formattedAmountSpent: String { return amountSpent.currencyFormat }
  var formattedAmountSpentWithCurrency: String { return currency.rawValue + " " + amountSpent.currencyFormat }
  var name: String {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMM yyyy"
    return formatter.string(from: self.date).capitalized
  }
  var maxExpenseDateForPeriod: Date? {
    if expenses.count == 0 {
      return nil
    } else {
      let descendingExpenseList = expenses.sorted { return $0.date >= $1.date }
      return descendingExpenseList[0].date
    }
  }
  var minExpenseDateForPeriod: Date? {
    if expenses.count == 0 {
      return nil
    } else {
      let ascendingExpenseList = expenses.sorted { return $1.date >= $0.date }
      return ascendingExpenseList[0].date
    }
  }
  var idExpensePeriod: String
  var total: Double {
    return expenses.reduce(0) { result, expense in result + expense.amount }
  }
  
  init(date: Date, currency: Currency) {
    self.date = date
    self.expenses = []
    self.currency = currency
    self.idExpensePeriod = UUID().uuidString
  }
  
  //MARK: - Update
  
  mutating func update(expense: Expense) {
    if let index = expenses.firstIndex(where: { $0.idExpense == expense.idExpense }) {
      expenses[index] = expense
    } else {
      expenses.insert(expense, at: 0)
    }
  }
  
  mutating func delete(expense: Expense) {
    guard let index = expenses.firstIndex(where: { $0.idExpense == expense.idExpense }) else { return }
    expenses.remove(at: index)
  }
  
  mutating func transformExpenseTo(currency: Currency, withRate rate: Double) {
    expenses = expenses.map {
      var newExp = $0
      newExp.amount *= rate
      newExp.currency = currency
      return newExp
    }
  }
  
  //MARK: - Periods
  
  func isPeriodIn(date: Date) -> Bool {
    return date.year() == year && date.month() == month
  }
  
  static func createPeriodsUpUntil(date: Date, fromPeriod: ExpensePeriod, withBudget budget: Double, currency: Currency, goal: Double) -> [ExpensePeriod] {
    var periods = [ExpensePeriod]()
    var period = fromPeriod
    var periodDate = fromPeriod.date
    var arrivedToCurrentPeriod = period.isPeriodIn(date: date)
    while !arrivedToCurrentPeriod {
      periodDate = periodDate.dateByAdding(years: 0, months: 1, days: 0)
      period = ExpensePeriod(date: periodDate.dateForFirstDayOfMonth(), currency: currency)
      periods.insert(period, at: 0)
      arrivedToCurrentPeriod = period.isPeriodIn(date: date)
    }
    return periods
  }
}

//MARK: - Coding Initializers

extension ExpensePeriod {
  
  private struct CodingKeys {
    static let ExpensesKey = "expenses"
    static let BudgetKey = "budget"
    static let DateKey = "date"
    static let IdExpensePeriodKey = "id expense period"
    static let CurrencyKey = "currency"
  }
  
  var plistRepresentation: [String: AnyObject] {
    return [CodingKeys.IdExpensePeriodKey: idExpensePeriod as AnyObject,
            CodingKeys.ExpensesKey: expenses.map { $0.plistRepresentation } as AnyObject,
            CodingKeys.CurrencyKey: currency.rawValue as AnyObject]
  }
  
  init(plist: [String: AnyObject]) {
    let periodDate = plist[CodingKeys.DateKey] as? Date ?? Date()
    date = periodDate
    idExpensePeriod = plist[CodingKeys.IdExpensePeriodKey] as? String ?? ""
    expenses = (plist[CodingKeys.ExpensesKey] as? [[String: AnyObject]] ?? [[:]]).map(Expense.init(plist:))
    currency = Currency(rawValue: plist[CodingKeys.CurrencyKey] as? String ?? "") ?? .dollars
  }
}
