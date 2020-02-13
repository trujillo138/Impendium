//
//  Double.swift
//  MyExpenses
//
//  Created by Tomas Trujillo on 7/10/17.
//  Copyright © 2017 TOMApps. All rights reserved.
//

import Foundation

extension Double {
  static var currencyFormatter: NumberFormatter {
    let numberFormatter = NumberFormatter()
    numberFormatter.locale = NSLocale.current
    numberFormatter.usesGroupingSeparator = true
    numberFormatter.numberStyle = .currency
    numberFormatter.currencySymbol = ""
    numberFormatter.maximumFractionDigits = 2
    return numberFormatter
  }
  
  var currencyFormat: String {
    return Double.currencyFormatter.string(from: NSNumber(value: self)) ?? Double.currencyFormatter.string(from: 0)!
  }
  
  static func doubleFromCurrency(text: String) -> Double {
    let numberFormatter = NumberFormatter()
    numberFormatter.locale = NSLocale.current
    numberFormatter.usesGroupingSeparator = true
    numberFormatter.numberStyle = .decimal
    numberFormatter.currencySymbol = ""
    numberFormatter.maximumFractionDigits = 2
    let number = numberFormatter.number(from: text)?.doubleValue ?? 0.00
    return number
  }
}
