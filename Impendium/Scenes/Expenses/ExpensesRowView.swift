//
//  ExpensesRowView.swift
//  Impendium
//
//  Created by Tomas Trujillo on 2020-02-04.
//  Copyright © 2020 Tomas Trujillo. All rights reserved.
//

import SwiftUI

struct ExpensesRowView: View {
  let name: String
  let totalAmount: String
  
  var body: some View {
    HStack {
      Text(name)
      Spacer()
      Text(totalAmount)
    }
    .frame(height: 100)
    .padding([.leading, .trailing])
    .background(Color.white)
    .cornerRadius(10)
    .shadow(color: .black, radius: 10, x: 0, y: 5)
  }
}

struct ExpensesRowView_Previews: PreviewProvider {
  static var previews: some View {
    ExpensesRowView(name: "Feb 2020", totalAmount: "CAD 2,845.89")
  }
}
