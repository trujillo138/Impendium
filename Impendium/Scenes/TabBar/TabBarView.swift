//
//  TabBarView.swift
//  MyExpenses
//
//  Created by Tomas Trujillo on 2019-12-10.
//  Copyright © 2019 TOMApps. All rights reserved.
//

import SwiftUI

struct TabBarView: View {
  var body: some View {
    TabView {
      OverviewView().tabItem { TabItemView(name: "Overview") }
      ExpensesView().tabItem { TabItemView(name: "Expenses") }
      GraphsView().tabItem { TabItemView(name: "Graphs") }
      SettingsView().tabItem { TabItemView(name: "Settings") }
    }
  }
}

private struct TabItemView: View {
  let name: String
  
  var body: some View {
    VStack {
      Image(name)
      Text(name)
    }
  }
}

struct TabBarView_Previews: PreviewProvider {
  static var previews: some View {
    TabBarView()
  }
}
