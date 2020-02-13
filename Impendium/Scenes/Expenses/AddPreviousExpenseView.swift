//
//  AddPreviousExpenseView.swift
//  Impendium
//
//  Created by Tomas Trujillo on 2020-02-05.
//  Copyright © 2020 Tomas Trujillo. All rights reserved.
//

import SwiftUI

struct AddPreviousExpenseView: View {
  @State private var selectedDate = Date().dateByAdding(years: 0, months: -1, days: 0)
  @Binding var isVisible: Bool
  
  private var previousMonth: Date {
    return Date().dateByAdding(years: 0, months: -1, days: 0)
  }
  var body: some View {
    NavigationView {
      VStack {
        DatePicker(selection: $selectedDate, in: ...previousMonth, displayedComponents: .date) {
          Text("Period date")
        }
        Spacer()
      }
      .padding()
      .navigationBarItems(leading: Button(action: { self.isVisible.toggle() }) {
        Text("Cancel")
      }, trailing: Button(action: {
        self.add()
        self.isVisible.toggle()
      }) {
        Text("Add")
      })
    }
  }
}

private extension AddPreviousExpenseView {
  func add() {
    let dates = [Date(), Date().dateByAdding(years: 0, months: -1, days: 0), Date().dateByAdding(years: 0, months: -2, days: 0),
                  Date().dateByAdding(years: 0, months: -3, days: 0), Date().dateByAdding(years: 0, months: -4, days: 0), Date().dateByAdding(years: 0, months: -5, days: 0), Date().dateByAdding(years: 0, months: -6, days: 0), Date().dateByAdding(years: 0, months: -7, days: 0), Date().dateByAdding(years: 0, months: -8, days: 0), Date().dateByAdding(years: 0, months: -9, days: 0), Date().dateByAdding(years: 0, months: -10, days: 0)]
    FileExpensesStorage.shared.addPeriod(ExpensePeriod(date: dates.randomElement()!, currency: .canadianDollar))
  }
}

struct AddPreviousExpenseView_Previews: PreviewProvider {
  static var previews: some View {
    AddPreviousExpenseView(isVisible: .constant(true))
  }
}
