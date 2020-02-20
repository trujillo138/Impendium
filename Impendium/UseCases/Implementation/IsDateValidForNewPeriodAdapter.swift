//
//  IsDateValidForNewPeriodAdapter.swift
//  Impendium
//
//  Created by Tomas Trujillo on 2020-02-17.
//  Copyright © 2020 Tomas Trujillo. All rights reserved.
//

import Foundation

final class IsDateValidForNewPeriodAdapter: IsDateValidForNewPeriod {
  struct Dependencies: ServiceInjectable {
    var expensesStorage: ExpensesStorage = inject()
  }
  let dependencies: Dependencies
  
  init(dependencies: Dependencies = .init()) {
    self.dependencies = dependencies
  }
  
  func execute(date: Date) -> Bool {
    let dates:[(month: Int, year: Int)] = dependencies.expensesStorage.periods.map { (month: $0.date.month(), year: $0.date.year()) }
    let month = date.month()
    let year = date.year()
    return !dates.contains { $0.month == month && $0.year == year }
  }
}

extension UseCaseInjectable {
  static func inject() -> IsDateValidForNewPeriod {
    return IsDateValidForNewPeriodAdapter()
  }
}
