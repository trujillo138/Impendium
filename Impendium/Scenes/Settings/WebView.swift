//
//  WebView.swift
//  MyExpenses
//
//  Created by Tomas Trujillo on 2019-12-13.
//  Copyright © 2019 TOMApps. All rights reserved.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
  let url: String
  
  func makeUIView(context: Context) -> WKWebView {
    let webView = WKWebView()
    guard
      let siteURL = URL(string: url)
    else { return webView }
    let urlRequest = URLRequest(url: siteURL)
    webView.load(urlRequest)
    return webView
  }
  
  func updateUIView(_ webView: WKWebView, context: Context) {
    guard
      let siteURL = URL(string: url)
    else { return }
    let urlRequest = URLRequest(url: siteURL)
    webView.load(urlRequest)
  }
  
}

struct WebView_Previews: PreviewProvider {
  static var previews: some View {
    WebView(url: "www.google.com")
  }
}
