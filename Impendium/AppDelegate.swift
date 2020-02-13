//
//  AppDelegate.swift
//  Impendium
//
//  Created by Tomas Trujillo on 2020-01-31.
//  Copyright © 2020 Tomas Trujillo. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    return true
  }

  // MARK: UISceneSession Lifecycle

  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }

  func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
  }


}



////MARK: Sorting
//
//func sortExpensesBy(option: ExpensePeriodSortOption, ascending: Bool) -> [Expense] {
//    return sortExpenseListBy(option: option, ascending: ascending, expenseList: expenses)
//}
//
//private func sortExpenseListBy(option: ExpensePeriodSortOption, ascending: Bool, expenseList: [Expense]) -> [Expense] {
//    switch option {
//    case .amount:
//        return ascending ? expenseList.sorted { return $0.amount < $1.amount } : expenseList.sorted { return $0.amount >= $1.amount }
//    case .date:
//        return ascending ? expenseList.sorted { return $0.date < $1.date } : expenseList.sorted { return $0.date >= $1.date }
//    case .name:
//        return ascending ? expenseList.sorted { return $0.name < $1.name } : expenseList.sorted { return $0.name >= $1.name }
//    case .type:
//        return ascending ? expenseList.sorted { return $0.expenseType.displayName < $1.expenseType.displayName } :
//            expenseList.sorted { return $0.expenseType.displayName >= $1.expenseType.displayName }
//    }
//}
//
////MARK: Filtering
//
//func filterExpensesBy(filter: ExpensePeriodFilterOption, fromValue: Any?, toValue: Any?) -> [Expense] {
//    switch filter {
//    case .amount:
//        if let frmValue = fromValue as? Double {
//            return filterExpensesBy(amount: frmValue, greaterThan: true)
//        } else {
//            return filterExpensesBy(amount: toValue as? Double ?? 0.0, greaterThan: false)
//        }
//    case .type:
//        return filterExpensesBy(type: ExpenseType(rawValue: fromValue as? String ?? "") ?? .food)
//    case .date:
//        return filterExpensesFrom(date: fromValue as? Date, to: toValue as? Date)
//    }
//}
//
//private func filterExpensesBy(amount: Double, greaterThan: Bool) -> [Expense] {
//    return expenses.filter { return greaterThan ? $0.amount >= amount : $0.amount <= amount }
//}
//
//private func filterExpensesFrom(date: Date?, to: Date?) -> [Expense] {
//    var filteredExpenses = [Expense]()
//    if let fromDate = date, let toDate = to {
//        filteredExpenses = expenses.filter { return $0.date >= fromDate && $0.date <= toDate }
//    } else if let fromDate = date {
//        filteredExpenses = expenses.filter { return $0.date >= fromDate }
//    } else if let toDate = to {
//        filteredExpenses = expenses.filter { return $0.date <= toDate }
//    }
//    return filteredExpenses
//}
//
//private func filterExpensesBy(type: ExpenseType) -> [Expense] {
//    return expenses.filter { return $0.expenseType == type }
//}
//
////MARK: Sort & Filter
//
//func filterAndSortExpensesBy(filter: ExpensePeriodFilterOption, fromValue: Any?, toValue: Any?, option: ExpensePeriodSortOption, ascending: Bool) -> [Expense] {
//    let filteredExpenses = filterExpensesBy(filter: filter, fromValue: fromValue, toValue: toValue)
//    return sortExpenseListBy(option: option, ascending: ascending, expenseList: filteredExpenses)
//}
