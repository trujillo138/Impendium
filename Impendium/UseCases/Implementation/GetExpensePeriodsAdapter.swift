//
//  GetExpensePeriodsAdapter.swift
//  Impendium
//
//  Created by Tomas Trujillo on 2020-02-05.
//  Copyright © 2020 Tomas Trujillo. All rights reserved.
//

import Foundation
import Combine

final class GetExpensePeriodsAdapter: GetExpensePeriods {
  struct Dependencies: ServiceInjectable {
    var expensesStorage: ExpensesStorage = inject()
  }
  let dependencies: Dependencies
  
  init(dependencies: Dependencies = .init()) {
    self.dependencies = dependencies
  }
  
  func execute() -> AnyPublisher<[ExpensePeriod], Never> {
    return dependencies.expensesStorage.expensesPublisher
  }
}

extension UseCaseInjectable {
  static func inject() -> GetExpensePeriods {
    return GetExpensePeriodsAdapter()
  }
}
