//
//  PrivacyPolicyView.swift
//  Montreal Luxe Resort
//
//  Created by Artur on 17.09.2024.
//

import SwiftUI

struct PrivacyPolicyView: View {
    @Environment(\.dismiss) var dismiss

       var body: some View {
           NavigationView {
               WebView(url: URL(string: "https://www.termsfeed.com/live/92289e32-cbab-46e2-a7bc-1f152d756dfd")!)
                   .navigationTitle("Privacy Policy")
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
    PrivacyPolicyView()
}

