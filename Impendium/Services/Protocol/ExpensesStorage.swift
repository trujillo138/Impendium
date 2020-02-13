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
  var expenses: AnyPublisher<[ExpensePeriod], Never> { get }
  func addPeriod(_: ExpensePeriod)
}
