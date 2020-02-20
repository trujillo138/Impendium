//
//  AlertView.swift
//  Impendium
//
//  Created by Tomas Trujillo on 2020-02-17.
//  Copyright © 2020 Tomas Trujillo. All rights reserved.
//

import SwiftUI

struct AlertView<T: View>: View {
  @Binding var showing: Bool
  let content: (() -> T)
  
  var body: some View {
    ZStack {
      Color.black
        .opacity(0.4)
        .onTapGesture { self.showing.toggle() }
      VStack(alignment: .center) {
        content()
        .frame(height: 400)
      }
      .background(Color.white)
      .cornerRadius(10.0)
      .padding()
    }
  }
}
struct AlertView_Previews: PreviewProvider {
    static var previews: some View {
      AlertView(showing: .constant(true)) {
        Color.black
      }
    }
}
