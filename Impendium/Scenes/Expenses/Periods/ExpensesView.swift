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
  let images: [String]
}

struct ExpensesView: View {
  @State private var showingAddPreviousExpenseView = false
  @ObservedObject var viewModel: ExpensesViewModel
  
  init(viewModel: ExpensesViewModel = .init()) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    NavigationView {
      ZStack {
        VStack {
          if viewModel.expenses.isEmpty {
            Text("No expense periods")
          } else {
            ScrollView {
              ForEach(viewModel.expenses, id: \.id) { item in
                ZStack {
                  NavigationLink(destination: MyInfoView()) {
                    EmptyView()
                  }
                  ExpensesRowView(name: item.name, totalAmount: item.total, images: item.images)
                }.padding([.leading, .trailing, .bottom])
              }
            }
          }
          Spacer()
        }
        if showingAddPreviousExpenseView {
          AlertView(showing: $showingAddPreviousExpenseView) {
            AddPreviousExpenseView(isVisible: self.$showingAddPreviousExpenseView)
          }
        }
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
    .onDisappear { self.showingAddPreviousExpenseView = false }
  }
}

struct ExpensesView_Previews: PreviewProvider {
  static var previews: some View {
    ExpensesView(viewModel: ExpensesViewModel.testViewModel())
  }
}
