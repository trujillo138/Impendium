//
//  MockIsDateValidForNewPeriod.swift
//  ImpendiumTests
//
//  Created by Tomas Trujillo on 2020-02-19.
//  Copyright © 2020 Tomas Trujillo. All rights reserved.
//

import Foundation
@testable import Impendium

final class MockIsDateValidForNewPeriod: IsDateValidForNewPeriod, Mockable {
  var mockExecute = Mock()
  
  func execute(date: Date) -> Bool {
    return performAndReturn(mockExecute, parameters: date)
  }
}
