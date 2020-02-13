//
//  SettingsViewModelTests.swift
//  ImpendiumTests
//
//  Created by Tomas Trujillo on 2020-02-02.
//  Copyright © 2020 Tomas Trujillo. All rights reserved.
//

import XCTest
@testable import Impendium

class SettingsViewModelTests: XCTestCase {
  
  var sut: SettingsViewModel!
  var applicationService: MockApplicationService!
  
  override func setUp() {
    super.setUp()
    applicationService = MockApplicationService()
    let dependencies = SettingsViewModel.Dependencies(applicationService: applicationService)
    sut = SettingsViewModel(dependencies: dependencies)
  }
  
  override func tearDown() {
    applicationService = nil
    sut = nil
    super.tearDown()
  }
  
  func test_PrivacyPolicyURL_ReturnsPrivacyURL() {
    // Given
    let expectedURL = "https://www.iubenda.com/privacy-policy/99250421"
    
    // When
    let privacyURL = sut.privacyURL
    
    // Then
    XCTAssertEqual(expectedURL, privacyURL, "The URL doesn't correspond to the privacy policy")
  }
  
  func test_AboutURL_ReturnsAboutWebsiteURL() {
    // Given
    let expectedURL = "https://ttrujillo138.wixsite.com/impendium"
    
    // When
    let aboutURL = sut.aboutURL
    
    // Then
    XCTAssertEqual(expectedURL, aboutURL, "The URL doesn't correspond to the about website")
  }
  
  func test_HandleSuggestionsSelected_OpensMailToURL() {
    // Given
    let expectedMailURL = "mailto:myexpenses.tt@gmail.com"
    
    // When
    sut.handleSuggestionsSelected()
    
    // Then
    XCTAssertTrue(applicationService.didCalledOpen, "Missing call to open suggestions url")
    XCTAssertNil(applicationService.completion, "Sut shouldn't do anything after openning URL")
    if let url = applicationService.passedURL {
      XCTAssertEqual(expectedMailURL, url.absoluteString, "The URL passed to the service is not the expected one")
    }
    else {
      XCTFail("Should pass a URL to the application service")
    }
  }
}
