//
//  WelcomeView.swift
//  Montreal Luxe Resort
//
//  Created by Artur on 11.09.2024.
//

import SwiftUI

struct WelcomeView: View {
    @State private var isHotel = false
    @State private var isQuiz = false
    @State private var isInteresting = false
    @State private var isSettings = false
    var body: some View {
        VStack{
            
            Button(action: {
                isHotel.toggle()
            }, label: {
                Image("Group 5")
            }).padding(.top,40)
            HStack{
                Button(action: {
                    isQuiz.toggle()
                }, label: {
                    Image("Group 3")
                })
                Button(action: {
                    isInteresting.toggle()
                }, label: {
                    Image("Group 4")
                })
            }
            Button(action: {
                isSettings.toggle()
            }, label: {
                Image("Group 6")
            })
            
            
        }.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,maxHeight: .infinity)
            .background(Image("home").ignoresSafeArea())
            .fullScreenCover(isPresented: $isInteresting, content: {
                InterestingView()
            })
            .fullScreenCover(isPresented: $isHotel, content: {
                HotelsView()
            })
            .fullScreenCover(isPresented: $isQuiz, content: {
                QuizView()
            })
            .fullScreenCover(isPresented: $isSettings, content: {
                SettingsView()
            })
    }
}

#Preview {
    WelcomeView()
}

