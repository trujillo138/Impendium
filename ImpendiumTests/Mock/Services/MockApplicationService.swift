//
//  MockApplicationService.swift
//  ImpendiumTests
//
//  Created by Tomas Trujillo on 2020-02-02.
//  Copyright © 2020 Tomas Trujillo. All rights reserved.
//

import Foundation
@testable import Impendium

final class MockApplicationService: ApplicationService {
  private(set) var didCalledOpen = false
  var passedURL: URL?
  var completion: ((Bool) -> Void)?
  func open(url: URL, completionHandler: ((Bool) -> Void)?) {
    didCalledOpen = true
    passedURL = url
    completion = completionHandler
  }
}
