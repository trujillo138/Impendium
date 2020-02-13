//
//  Collection.swift
//  MyExpenses
//
//  Created by Tomas Trujillo on 10/4/17.
//  Copyright © 2017 TOMApps. All rights reserved.
//

import Foundation

extension Array {
  func getFirst(nValues values: Int) -> [Iterator.Element] {
    var firstValues: [Iterator.Element] = []
    guard count > values else { return self }
    for i in 0 ..< values {
      firstValues.append(self[i])
    }
    return firstValues
  }
}

