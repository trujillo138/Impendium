//
//  SettingsRowView.swift
//  Impendium
//
//  Created by Tomas Trujillo on 2020-01-31.
//  Copyright © 2020 Tomas Trujillo. All rights reserved.
//

import SwiftUI

struct SettingsRowView: View {
  let imageName: String
  let name: String
  var body: some View {
    HStack {
      Image(imageName)
        .resizable()
        .scaledToFit()
        .frame(height: 75)
        .padding()
      Text(name)
        .font(.title)
      Spacer()
    }
  }
}

struct SettingsRowView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsRowView(imageName: "MyInfo", name: "My Info")
  }
}
