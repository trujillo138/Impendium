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
        $0.map { period in
          ExpensePeriodViewModel(id: period.idExpensePeriod,
                                                  name: period.name,
                                                  total: period.formattedAmountSpentWithCurrency,
                                                  images: self.getImages(from: period))
      }
    }.assign(to: \.expenses, on: self)
  }
  
  func getImages(from period: ExpensePeriod) -> [String] {
    let set = Set(period.expenses.map{ $0.expenseType })
    return set.map { $0.rawValue }
  }
}

extension ExpensesViewModel {
  static func testViewModel() -> ExpensesViewModel {
    let model = ExpensesViewModel()
    model.expenses = [ExpensePeriodViewModel(id: "1", name: "Jan 202", total: "CAD $3,020", images: ["Food", "Groceries", "Home"]),
                      ExpensePeriodViewModel(id: "2", name: "Feb 202", total: "CAD $2,213", images: ["Food", "Home"]),
                      ExpensePeriodViewModel(id: "3", name: "Mar 202", total: "CAD $500", images: ["Food", "Home"]),
                      ExpensePeriodViewModel(id: "4", name: "Apr 202", total: "CAD $4,100", images: ["Groceries", "Home"]),
                      ExpensePeriodViewModel(id: "5", name: "May 202", total: "CAD $6,250", images: ["Home"]),
                      ExpensePeriodViewModel(id: "6", name: "Jun 202", total: "CAD $2,350", images: ["Groceries"]),
                      ExpensePeriodViewModel(id: "7", name: "Jul 202", total: "CAD $1,050", images: ["Food", "Groceries"]),
                      ExpensePeriodViewModel(id: "8", name: "Aug 202", total: "CAD $0", images: ["Food", "Groceries", "Home"])
    ]
    return model
  }
}
