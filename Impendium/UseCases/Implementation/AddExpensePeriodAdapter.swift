//
//  AddExpensePeriodAdapter.swift
//  Impendium
//
//  Created by Tomas Trujillo on 2020-02-17.
//  Copyright © 2020 Tomas Trujillo. All rights reserved.
//

import Foundation

final class AddExpensePeriodAdapter: AddExpensePeriod {
  struct Dependencies: ServiceInjectable {
    var expensesStorage: ExpensesStorage = inject()
  }
  let dependencies: Dependencies
  
  init(dependencies: Dependencies = .init()) {
    self.dependencies = dependencies
  }
  
  func execute(date: Date) {
    let user = dependencies.expensesStorage.user
    let period = ExpensePeriod(date: date, currency: user.currentCurrency)
    dependencies.expensesStorage.addPeriod(period)
  }
}

extension UseCaseInjectable {
  static func inject() -> AddExpensePeriod {
    return AddExpensePeriodAdapter()
  }
}
