//
//  TermsofUseView.swift
//  Montreal Luxe Resort
//
//  Created by Artur on 17.09.2024.
//

import SwiftUI

struct TermsofUseView: View {
    @Environment(\.dismiss) var dismiss

       var body: some View {
           NavigationView {
               WebView(url: URL(string: "https://sites.google.com/view/termsandconditionsformontreall/")!)
                   .navigationTitle("Terms of Use")
                   .navigationBarTitleDisplayMode(.inline)
                   .navigationBarItems(trailing: Button(action: {
                       dismiss() // Закрытие представления при нажатии кнопки "Close"
                   }) {
                       Text("Close")
                           .foregroundColor(.blue)
                   })
           }
       }
}

#Preview {
    TermsofUseView()
}
