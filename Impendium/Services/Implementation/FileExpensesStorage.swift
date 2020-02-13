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
  
  var expenses: AnyPublisher<[ExpensePeriod], Never> {
    return $cachedExpenses.eraseToAnyPublisher()
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
