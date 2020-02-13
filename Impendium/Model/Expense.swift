//
//  Expense.swift
//  MyExpenses
//
//  Created by Tomas Trujillo on 5/18/17.
//  Copyright © 2017 TOMApps. All rights reserved.
//

import Foundation

struct Expense {
  var expenseType: ExpenseType
  var amount: Double
  var currency: Currency
  var name: String
  var date: Date
  var idExpense: String
  var formattedAmount: String {
    return amount.currencyFormat
  }
  var formattedAmountWithCurrency: String {
    return currency.rawValue + " " + amount.currencyFormat
  }
  var formattedDate: String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    return dateFormatter.string(from: date)
  }
  
  init(expenseType: ExpenseType, amount: Double, currency: Currency, name: String, date: Date) {
    self.expenseType = expenseType
    self.amount = amount
    self.currency = currency
    self.name = name
    self.date = date
    let currentDate = Date()
    self.idExpense = "\(currentDate.year())\(currentDate.month())\(currentDate.day())\(currentDate.hour())\(currentDate.minute())\(currentDate.second())"
  }
}

extension Expense {
  private struct CodingKeys {
    static let ExpenseTypeKey = "expense type"
    static let AmountKey = "amount"
    static let CurrencyKey = "currency"
    static let IdExpenseKey = "id expense"
    static let NameKey = "name"
    static let DateKey = "date"
  }
  
  var plistRepresentation: [String: AnyObject] {
    return [CodingKeys.ExpenseTypeKey: expenseType.rawValue as AnyObject, CodingKeys.AmountKey: amount as AnyObject,
            CodingKeys.CurrencyKey: currency.rawValue as AnyObject, CodingKeys.IdExpenseKey: idExpense as AnyObject,
            CodingKeys.NameKey: name as AnyObject, CodingKeys.DateKey: date as AnyObject]
  }
  
  init(plist: [String: AnyObject]) {
    expenseType = ExpenseType(rawValue: plist[CodingKeys.ExpenseTypeKey] as? String ?? "") ?? .food
    amount = plist[CodingKeys.AmountKey] as? Double ?? 0.0
    currency = Currency(rawValue: plist[CodingKeys.CurrencyKey] as? String ?? "") ?? .dollars
    idExpense = plist[CodingKeys.IdExpenseKey] as? String ?? ""
    name = plist[CodingKeys.NameKey] as? String ?? ""
    date = plist[CodingKeys.DateKey] as? Date ?? Date()
  }
}
