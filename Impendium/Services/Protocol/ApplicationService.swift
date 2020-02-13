//
//  ApplicationService.swift
//  Impendium
//
//  Created by Tomas Trujillo on 2020-02-02.
//  Copyright © 2020 Tomas Trujillo. All rights reserved.
//

import Foundation

protocol ApplicationService {
  func open(url: URL, completionHandler: ((Bool) -> Void)?)
}
