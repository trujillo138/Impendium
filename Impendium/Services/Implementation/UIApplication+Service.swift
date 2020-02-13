//
//  UIApplication+Service.swift
//  Impendium
//
//  Created by Tomas Trujillo on 2020-02-02.
//  Copyright © 2020 Tomas Trujillo. All rights reserved.
//

import UIKit

extension UIApplication: ApplicationService {
  func open(url: URL, completionHandler: ((Bool) -> Void)?) {
    open(url, options: [:], completionHandler: completionHandler)
  }
}

extension ServiceInjectable {
  static func inject() -> ApplicationService {
    return UIApplication.shared
  }
}
