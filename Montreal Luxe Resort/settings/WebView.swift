//
//  WebView.swift
//  Montreal Luxe Resort
//
//  Created by Artur on 17.09.2024.
//

import Foundation
import SwiftUI
import WebKit
struct WebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}
