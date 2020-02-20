//
//  AddPreviousExpenseViewModel.swift
//  Impendium
//
//  Created by Tomas Trujillo on 2020-02-19.
//  Copyright © 2020 Tomas Trujillo. All rights reserved.
//

import Foundation

final class AddPreviousExpenseViewModel {
  struct Dependencies: UseCaseInjectable {
    var isDateValid: IsDateValidForNewPeriod = inject()
    var addExpensePeriod: AddExpensePeriod = inject()
  }
  private let dependencies: Dependencies
  
  init(dependencies: Dependencies = .init()) {
    self.dependencies = dependencies
  }
  
  func isDateValidForNewExpensePeriod(date: Date) -> Bool {
    guard dependencies.isDateValid.execute(date: date) else {
      return false
    }
    dependencies.addExpensePeriod.execute(date: date)
    return true
  }
}
