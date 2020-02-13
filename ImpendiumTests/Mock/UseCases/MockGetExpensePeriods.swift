//
//  MockGetExpensePeriods.swift
//  ImpendiumTests
//
//  Created by Tomas Trujillo on 2020-02-05.
//  Copyright © 2020 Tomas Trujillo. All rights reserved.
//

import Foundation
import Combine
@testable import Impendium

final class MockGetExpensePeriods: GetExpensePeriods {
  let mockedExpensesPublisher = PassthroughSubject<[ExpensePeriod], Never>()
  private(set) var didCallExecute = false
  
  func execute() -> AnyPublisher<[ExpensePeriod], Never> {
    didCallExecute = true
    return mockedExpensesPublisher.eraseToAnyPublisher()
  }
}
