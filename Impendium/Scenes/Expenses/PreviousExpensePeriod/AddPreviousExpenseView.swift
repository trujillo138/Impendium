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
  private let viewModel = AddPreviousExpenseViewModel()
  @State var showingInvalidExpenseAlert: Bool = false
  
  private var previousMonth: Date {
    return Date().dateByAdding(years: 0, months: -1, days: 0)
  }
  var body: some View {
    VStack {
      HStack {
        Button(action: { self.isVisible.toggle() }) {
          Text("Cancel")
        }
        Spacer()
        
        Button(action: {
          if self.viewModel.isDateValidForNewExpensePeriod(date: self.selectedDate) {
            self.isVisible.toggle()
          } else {
            self.showingInvalidExpenseAlert.toggle()
          }
        }) {
          Text("Add")
        }
      }
      Form {
        DatePicker(selection: $selectedDate, in: ...previousMonth, displayedComponents: .date) {
          Text("Period date")
        }
      }
    }
    .padding()
    .alert(isPresented: $showingInvalidExpenseAlert) {
      Alert(title: Text("Invalid Date"),
            message: Text("Another period already has the selected month and date"),
            dismissButton: .default(Text("Ok"))
      )
    }
    
  }
}

struct AddPreviousExpenseView_Previews: PreviewProvider {
  static var previews: some View {
    AddPreviousExpenseView(isVisible: .constant(true))
  }
}
