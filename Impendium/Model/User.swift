//
//  User.swift
//  MyExpenses
//
//  Created by Tomas Trujillo on 5/22/17.
//  Copyright © 2017 TOMApps. All rights reserved.
//

import Foundation

enum UserErrors: Error {
  case RepeatedPeriod
}

struct User {
  var expensePeriods: [ExpensePeriod]
  var budgetPerPeriod: Double
  var savingGoalPerPeriod: Double
  var currentCurrency: Currency
  
  mutating func add(expensePeriod: ExpensePeriod) {
    expensePeriods.insert(expensePeriod, at: 0)
  }
  
  mutating func addPreviousExpensePeriod(expensePeriod: ExpensePeriod) throws -> Int {
    let periodYear = expensePeriod.date.year()
    let periodMonth = expensePeriod.date.month()
    for (index, period) in expensePeriods.enumerated() {
      let year = period.date.year()
      let month = period.date.month()
      if year == periodYear && month == periodMonth {
        throw UserErrors.RepeatedPeriod
      } else if (periodYear > year) || (periodYear == year && periodMonth > month) {
        expensePeriods.insert(expensePeriod, at: index)
        return index
      }
    }
    expensePeriods.append(expensePeriod)
    return expensePeriods.count - 1
  }
  
  mutating func update(expensePeriod: ExpensePeriod) {
    guard let index = expensePeriods.firstIndex(where: { $0.idExpensePeriod == expensePeriod.idExpensePeriod }) else { return }
    expensePeriods[index] = expensePeriod
  }
}

extension User {
  private struct CodingKeys {
    static let ExpensePeriodsKey = "expense periods"
    static let BudgetPerPeriodKey = "budget per period"
    static let SavingGoalPerPeriodKey = "saving goal per period"
    static let CurrentCurrencyKey = "current currency"
  }
  
  var plistRepresentation: [String: AnyObject] {
    return [CodingKeys.BudgetPerPeriodKey: budgetPerPeriod as AnyObject, CodingKeys.SavingGoalPerPeriodKey: savingGoalPerPeriod as AnyObject,
            CodingKeys.CurrentCurrencyKey: currentCurrency.rawValue as AnyObject,
            CodingKeys.ExpensePeriodsKey: expensePeriods.map { $0.plistRepresentation } as AnyObject]
  }
  
  init(plist: [String: AnyObject]) {
    budgetPerPeriod = plist[CodingKeys.BudgetPerPeriodKey] as? Double ?? 0.0
    savingGoalPerPeriod = plist[CodingKeys.SavingGoalPerPeriodKey] as? Double ?? 0.0
    currentCurrency = Currency(rawValue: plist[CodingKeys.CurrentCurrencyKey] as? String ?? "") ?? .dollars
    expensePeriods = (plist[CodingKeys.ExpensePeriodsKey] as? [[String: AnyObject]] ?? [[:]]).map(ExpensePeriod.init(plist:))
  }
  
  init() {
    budgetPerPeriod = 0.0
    savingGoalPerPeriod = 0.0
    currentCurrency = .dollars
    expensePeriods = [ExpensePeriod]()
  }
  
}
