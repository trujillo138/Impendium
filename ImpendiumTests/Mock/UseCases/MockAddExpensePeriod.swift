//
//  MockAddExpensePeriod.swift
//  ImpendiumTests
//
//  Created by Tomas Trujillo on 2020-02-19.
//  Copyright © 2020 Tomas Trujillo. All rights reserved.
//

import Foundation
@testable import Impendium

final class MockAddExpensePeriod: AddExpensePeriod, Mockable {
  var mockExecute = Mock()
  
  func execute(date: Date) {
    perform(mockExecute, parameters: date)
  }
}
