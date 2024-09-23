//
//  ContentView.swift
//  Montreal Luxe Resort
//
//  Created by Artur on 11.09.2024.
//

import SwiftUI


struct ContentView: View {
    @AppStorage("isEULAAccepted") private var isEULAAccepted: Bool = false
    @State private var isWelcome = false
    var body: some View {
        if isEULAAccepted {
            VStack{
                Spacer()
                Button(action: {
                    isWelcome.toggle()
                }, label: {
                    
                    Image("Frame 5")
                }).padding(.bottom,20)
                
            }.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,maxHeight: .infinity)
                .background(Image("onboarding")
                    .ignoresSafeArea()
                )
                .fullScreenCover(isPresented: $isWelcome, content: {
                    WelcomeView()
                })
        }else{
            EULAScreen()
        }
    }
 
}



#Preview {
    ContentView()
}
