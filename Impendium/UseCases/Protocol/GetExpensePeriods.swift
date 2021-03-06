//
//  GetExpensePeriods.swift
//  Impendium
//
//  Created by Tomas Trujillo on 2020-02-05.
//  Copyright © 2020 Tomas Trujillo. All rights reserved.
//

import Foundation
import Combine

protocol GetExpensePeriods {
  func execute() -> AnyPublisher<[ExpensePeriod], Never>
}
