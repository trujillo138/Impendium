//
//  ExpensesViewModel.swift
//  Impendium
//
//  Created by Tomas Trujillo on 2020-02-05.
//  Copyright © 2020 Tomas Trujillo. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

final class ExpensesViewModel: ObservableObject {
  struct Dependencies: UseCaseInjectable {
    var getExpensePeriods: GetExpensePeriods = inject()
  }
  let dependencies: Dependencies
  private var getExpensesCancellable: AnyCancellable?
  @Published var expenses: [ExpensePeriodViewModel] = []
  
  init(dependencies: Dependencies = .init()) {
    self.dependencies = dependencies
    observe()
  }
}

private extension ExpensesViewModel {
  func observe() {
    getExpensesCancellable = dependencies.getExpensePeriods.execute().map {
        $0.map { period in ExpensePeriodViewModel(id: period.idExpensePeriod,
                                                  name: period.name,
                                                  total: period.formattedAmountSpentWithCurrency) }
    }.assign(to: \.expenses, on: self)
  }
}
