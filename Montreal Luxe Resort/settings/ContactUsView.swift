//
//  ContactUsView.swift
//  Montreal Luxe Resort
//
//  Created by Artur on 17.09.2024.
//

import SwiftUI

struct ContactUsView: View {

    @State private var showMessage = false
    @State private var name: String = ""
       @State private var email: String = ""
       @State private var message: String = ""
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    Button(action: {
                        self.dismiss()
                    }, label: {
                        Image("tabler-icon-arrow-narrow-left 1")
                    })
                   
                    Image("coonaw").padding(.leading,20)
                    Spacer()
                }.padding(.leading,30)
                .padding(.top,30)
                
                
                ZStack{
                
                    VStack(alignment: .leading, spacing: 5) {
                                Group {
                                    // Поле для ввода имени
                                    Text("Your Name")
                                        .font(.headline)
                                        .foregroundColor(Color("col6"))
                                    
                                    TextField("Enter Your Name", text: $name)
                                        .padding()
                                        .background(Color("col6"))
                                        .cornerRadius(10)
                                        .foregroundColor(.black)
                                        .font(.system(size: 18, weight: .bold))
                                    
                                    // Поле для ввода email
                                    Text("Email")
                                        .font(.headline)
                                        .foregroundColor(Color("col6"))
                                    
                                    TextField("Enter Your Email", text: $email)
                                        .padding()
                                        .background(Color("col6"))
                                        .cornerRadius(10)
                                        .foregroundColor(.black)
                                        .font(.system(size: 18, weight: .bold))
                                        .keyboardType(.emailAddress)
                                    
                                    // Поле для ввода сообщения
                                    Text("Message")
                                        .font(.headline)
                                        .foregroundColor(Color("col6"))
                                    
                                    TextEditor(text: $message)
                                        .padding()
                                        .background(Color("col6"))
                                        .cornerRadius(10)
                                        .foregroundColor(.black)
                                        .font(.system(size: 18, weight: .bold))
                                        .frame(height: 150)
                                        .scrollContentBackground(.hidden) // Убирает стандартный фон
                                        .background(Color.purple.opacity(0.3))
                                }
                                
                            
                    }.padding(.horizontal,50)
                        .padding(.vertical,0)
                          
                           
                   
                }.padding(.top,100)
                Button(action: {
                    showMessage.toggle()
                }, label: {
                   Image("sssqa")
                }).padding(.top,30)
                Spacer()
                
            }
           
        }
        .overlay(
            VStack {
                if showMessage {
                    ZStack {
                        Color.black.opacity(0.9).ignoresSafeArea()
                        Image("Frame 38").frame(maxWidth: 300, maxHeight: 300)
                        
                        Button(action: {
                            self.dismiss()
                        }, label: {
                            Image("ok")
                            
                        }).padding(.top,130)
                    }
                    .transition(.opacity)
                }
            
            }
        
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            .zIndex(1)
        )
        .background(Color("col5")
            .ignoresSafeArea()
        )
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    ContactUsView()
}

