//
//  MockExpensesStorage.swift
//  ImpendiumTests
//
//  Created by Tomas Trujillo on 2020-02-17.
//  Copyright © 2020 Tomas Trujillo. All rights reserved.
//

import Foundation
import Combine
@testable import Impendium

final class MockExpensesStorage: ExpensesStorage, Mockable {
  var mockExpensesPublisher = Mock()
  var mockAddPeriod = Mock()
  var mockUser = Mock()
  var mockPeriods = Mock()
  
  var user: User {
    return performAndReturn(mockUser, parameters: ())
  }
  
  var expensesPublisher: AnyPublisher<[ExpensePeriod], Never> {
    return performAndReturn(mockExpensesPublisher, parameters: ())
  }
  
  var periods: [ExpensePeriod] {
    return performAndReturn(mockPeriods, parameters: ())
  }
  
  func addPeriod(_ period: ExpensePeriod) {
    perform(mockAddPeriod, parameters: period)
  }
  
  
}
