//
//  ExpensesStorage.swift
//  Impendium
//
//  Created by Tomas Trujillo on 2020-02-09.
//  Copyright © 2020 Tomas Trujillo. All rights reserved.
//

import Foundation
import Combine

protocol ExpensesStorage {
  var user: User { get }
  var periods: [ExpensePeriod] { get }
  var expensesPublisher: AnyPublisher<[ExpensePeriod], Never> { get }
  func addPeriod(_: ExpensePeriod)
}
