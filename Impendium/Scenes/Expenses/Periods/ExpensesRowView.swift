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
  let images: [String]
  
  var body: some View {
    HStack {
      VStack(alignment: .leading) {
        Text(name)
        HStack {
          if images.isEmpty {
            EmptyView()
          } else {
            ForEach(images.getFirst(nValues: 6), id: \.self) { IconImage(name: $0) }
          }
        }
      }
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

struct IconImage: View {
  let name: String
  
  var body: some View {
    Image(name)
      .resizable()
      .frame(width: 20, height: 20)
      
  }
}

struct ExpensesRowView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      ExpensesRowView(name: "Feb 2020",
                      totalAmount: "CAD 2,845.89",
                      images: ["Food", "Groceries", "Home", "Entertainment"])
      ExpensesRowView(name: "Mar 2020",
                      totalAmount: "CAD 0",
                      images: [])
    }
  }
}
