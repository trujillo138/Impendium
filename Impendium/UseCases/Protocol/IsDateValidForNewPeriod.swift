//
//  IsDateValidForNewPeriod.swift
//  Impendium
//
//  Created by Tomas Trujillo on 2020-02-17.
//  Copyright © 2020 Tomas Trujillo. All rights reserved.
//

import Foundation

protocol IsDateValidForNewPeriod {
  func execute(date: Date) -> Bool
}
