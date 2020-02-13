//
//  DateFunctions.swift
//  MyExpenses
//
//  Created by Tomas Trujillo on 5/29/17.
//  Copyright © 2017 TOMApps. All rights reserved.
//

import Foundation

extension Date {
  var shortFormat: String {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    return formatter.string(from: self)
  }
  
  var mediumFormat: String {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter.string(from: self)
  }
  
  var longFormat: String {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    return formatter.string(from: self)
  }
  
  func year() -> Int {
    let calendar = Calendar.current
    let components = calendar.dateComponents([.year], from: self)
    return components.year ?? 0
  }
  
  func month() -> Int {
    let calendar = Calendar.current
    let components = calendar.dateComponents([.month], from: self)
    return components.month ?? 0
  }
  
  func day() -> Int {
    let calendar = Calendar.current
    let components = calendar.dateComponents([.day], from: self)
    return components.day ?? 0
  }
  
  func hour() -> Int {
    let calendar = Calendar.current
    let components = calendar.dateComponents([.hour], from: self)
    return components.hour ?? 0
  }
  
  func minute() -> Int {
    let calendar = Calendar.current
    let components = calendar.dateComponents([.minute], from: self)
    return components.minute ?? 0
  }
  
  func second() -> Int {
    let calendar = Calendar.current
    let components = calendar.dateComponents([.second], from: self)
    return components.second ?? 0
  }
  
  func dateByAdding(years: Int, months: Int, days: Int) -> Date {
    var dateComponents = DateComponents()
    dateComponents.year = years
    dateComponents.month = months
    dateComponents.day = days
    
    return Calendar.current.date(byAdding: dateComponents, to: self)!
  }
  
  func dateForFirstDayOfMonth() -> Date {
    var dateComponents = DateComponents()
    dateComponents.year = self.year()
    dateComponents.month = self.month()
    //Doing this so that the change in time zone does not affect the periods
    dateComponents.day = 2
    
    return Calendar.current.date(from: dateComponents)!
  }
  
  static func dateWithComponents(years: Int, months: Int, days: Int) -> Date {
    var dateComponents = DateComponents()
    dateComponents.year = years
    dateComponents.month = months
    dateComponents.day = days
    
    return Calendar.current.date(from: dateComponents)!
  }
}
