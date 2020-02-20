//
//  FileExpensesStorage.swift
//  Impendium
//
//  Created by Tomas Trujillo on 2020-02-09.
//  Copyright © 2020 Tomas Trujillo. All rights reserved.
//

import Foundation
import Combine

final class FileExpensesStorage: ExpensesStorage {
  static let shared = FileExpensesStorage()
  var user = User()
  var expensesPublisher: AnyPublisher<[ExpensePeriod], Never> {
    return $cachedExpenses.eraseToAnyPublisher()
  }
  var periods: [ExpensePeriod] {
    return cachedExpenses
  }
  @Published private var cachedExpenses: [ExpensePeriod] = []
  
  private init() {}
  
  func addPeriod(_ period: ExpensePeriod) {
    cachedExpenses.append(period)
  }
}

extension ServiceInjectable {
  static func inject() -> ExpensesStorage {
    return FileExpensesStorage.shared
  }
}
