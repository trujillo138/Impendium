//
//  SettingsView.swift
//  Impendium
//
//  Created by Tomas Trujillo on 2020-01-31.
//  Copyright © 2020 Tomas Trujillo. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
  let viewModel = SettingsViewModel()
  var body: some View {
    NavigationView {
      VStack {
        List {
          Section(header: HeaderView(title: "Profile")) {
            NavigationLink(destination: MyInfoView()) {
              SettingsRowView(imageName: "MyInfo", name: "My Info")
            }
            NavigationLink(destination: WebView(url: viewModel.privacyURL)) {
              SettingsRowView(imageName: "Privacy", name: "Privacy policy")
            }
          }.background(Color.clear)
          
          Section(header: HeaderView(title: "About Impendium")) {
            NavigationLink(destination: WebView(url: viewModel.aboutURL)) {
              SettingsRowView(imageName: "About", name: "About")
            }
            SettingsRowView(imageName: "Suggestions", name: "Suggestions")
              .onTapGesture {
                self.viewModel.handleSuggestionsSelected()
            }
          }
        }.listStyle(GroupedListStyle())
        Spacer()
      }
      .navigationBarTitle("Settings")
    }
  }
}

struct HeaderView: View {
  let title: String
  var body: some View {
    HStack {
      Text(title)
        .bold()
        .font(.title)
    }
  }
}

struct SettingsView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsView()
  }
}
