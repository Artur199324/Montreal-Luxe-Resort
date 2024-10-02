//
//  SettingsView.swift
//  Montreal Luxe Resort
//
//  Created by Artur on 17.09.2024.
//

import SwiftUI
import StoreKit
struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    @State private var isContakt = false
    @State private var isRete = false
    @State private var isTerms = false
    @State private var isPolisi = false
    var body: some View {
        VStack{
            VStack {
                HStack {
                    Button {
                        self.dismiss()
                    } label: {
                        Image("tabler-icon-arrow-narrow-left 1")
                    }
                    .padding(.leading, 20)
                    
                    Text("Settings")
                        .foregroundColor(.white)
                        .font(.title.bold())
                        .padding(.leading, 20)
                    
                    Spacer()
                    
                    
                }.padding(.top, 30)
                
                Button(action: {
                    self.isContakt.toggle()
                }, label: {
                   Image("set1")
                })
                Button(action: {
                    requestAppReview()
                }, label: {
                   Image("set2")
                })
                Button(action: {
                    self.isTerms.toggle()
                }, label: {
                   Image("set3")
                })
                Button(action: {
                    self.isPolisi.toggle()
                }, label: {
                    Image("set4")
                })
                Spacer()
            }
                
        }.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,maxHeight: .infinity)
            .background(Image("hotels").ignoresSafeArea())
            .fullScreenCover(isPresented: $isContakt, content: {
                ContactUsView()
            })
            .fullScreenCover(isPresented: $isTerms, content: {
                TermsofUseView()
            })
            .fullScreenCover(isPresented: $isPolisi, content: {
                PrivacyPolicyView()
            })
    }
    
    
    func requestAppReview() {
           if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
               SKStoreReviewController.requestReview(in: scene)
           }
       }
}

#Preview {
    SettingsView()
}
