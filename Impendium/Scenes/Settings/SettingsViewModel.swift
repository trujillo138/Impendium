//
//  SettingsViewModel.swift
//  Impendium
//
//  Created by Tomas Trujillo on 2020-02-02.
//  Copyright © 2020 Tomas Trujillo. All rights reserved.
//

import Foundation

final class SettingsViewModel {
  struct Dependencies: ServiceInjectable {
    var applicationService: ApplicationService = inject()
  }
  let dependencies: Dependencies
  var aboutURL: String {
    return "https://ttrujillo138.wixsite.com/impendium"
  }
  var privacyURL: String {
    return "https://www.iubenda.com/privacy-policy/99250421"
  }
  
  init(dependencies: Dependencies = .init()) {
    self.dependencies = dependencies
  }
  
  func handleSuggestionsSelected() {
    guard let url = URL(string: "mailto:myexpenses.tt@gmail.com") else { return }
    dependencies.applicationService.open(url: url, completionHandler: nil)
  }
}
