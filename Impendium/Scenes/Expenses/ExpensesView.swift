//
//  ExpensesView.swift
//  Impendium
//
//  Created by Tomas Trujillo on 2020-01-31.
//  Copyright © 2020 Tomas Trujillo. All rights reserved.
//

import SwiftUI

struct ExpensePeriodViewModel {
  let id: String
  let name: String
  let total: String
}

struct ExpensesView: View {
  @State private var showingAddPreviousExpenseView = false
  @ObservedObject var viewModel = ExpensesViewModel()
  
  var body: some View {
    NavigationView {
      VStack {
        ScrollView {
          ForEach(viewModel.expenses, id: \.id) { element in
            ZStack {
              NavigationLink(destination: MyInfoView()) {
                EmptyView()
              }
              ExpensesRowView(name: element.name, totalAmount: element.total)
            }.padding()
          }
        }
        Spacer()
      }
    .navigationBarTitle("Expenses")
    .navigationBarItems(trailing:
      Button(action: {
        self.showingAddPreviousExpenseView.toggle()
      }) {
        Image(systemName: "plus.square")
          .font(.title)
      }
      )
    }
    .sheet(isPresented: $showingAddPreviousExpenseView) {
      AddPreviousExpenseView(isVisible: self.$showingAddPreviousExpenseView)
    }
  }
}

struct ExpensesView_Previews: PreviewProvider {
  static var previews: some View {
    ExpensesView()
  }
}
