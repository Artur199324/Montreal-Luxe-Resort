//
//  Hotel7View.swift
//  Montreal Luxe Resort
//
//  Created by Artur on 11.09.2024.
//

import SwiftUI

struct Hotel7View: View {
    @State var booking = false
    @EnvironmentObject var commentsManager: CommentsManager
    let category: String = "hotel7"
    @State private var name: String = ""
    @State private var message: String = ""
    @Environment(\.dismiss) var dismiss
    @State private var selectedSegment = 0
    private let segments = ["Description", "Photos"]
    @State var isbigImage = false
    @State var bigImage = "po1"
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack {
                    Button(action: {
                        self.dismiss()
                    }, label: {
                        Image("tabler-icon-arrow-narrow-left 1")
                    })
                    Spacer()
                }
                .padding(.top, 50)
                .padding(.leading, 20)
                
                Picker("", selection: $selectedSegment) {
                    ForEach(Array(segments.enumerated()), id: \.offset) { index, segment in
                        Text(segment)
                            .tag(index)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                .background(Color.purple.opacity(0.2)) // Фон для всего Picker
                .cornerRadius(20) // Скругление углов
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.purple.opacity(0.5), lineWidth: 2) // Рамка вокруг Picker
                )
                .padding(.horizontal, 16)
                .padding(.top, 300)
                
                if selectedSegment == 0 {
                    // Описание отеля
                    ScrollView {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Loews Hotel Vogue")
                                .font(.title)
                                .padding()
                            Text("Welcome to Vogue Hotel Montreal Downtown Curio Collection by Hilton. Nestled amongst the popular boutiques and world-renowned museums and galleries in the heart of Montreal's Golden Square Mile, the city's fashionable culture hub.\n\nThe Vogue Hotel Montreal brings together the sophistication of legendary luxury hotels around the world with a chic intimacy and spirit that celebrates local culture and style.\n\nWe hope you enjoy Yama our mountain-inspired restaurant and cocktail bar from the imagination of renowned Chef Antonio Park as well as the elegant pastries prepared in the French tradition at Cafe Bazin.\n\nEnjoy the Cabinet of Curiosities in our main floor library as you take in the sights and sounds of Montreal's best address.")
                                .padding(.horizontal)
                            Image("Frame 32")
                                .resizable()
                                .scaledToFit()
                                .padding()
                        }
                        Button {
                            booking.toggle()
                        } label: {
                            Image("Frame 15")
                        }
                    }
                } else if selectedSegment == 1 {
                    // Фотографии отеля
                    VStack {
                        
                        
                        HStack {
                            Button {
                                isbigImage.toggle()
                                bigImage = "po1"
                            } label: {
                                Image("y1")
                                    .resizable()
                                    .scaledToFit()
                            }
                            
                            Button {
                                isbigImage.toggle()
                                bigImage = "po2"
                            } label: {
                                Image("y2")
                                    .resizable()
                                    .scaledToFit()
                            }
                            
                            
                        }
                        HStack {
                            Button {
                                isbigImage.toggle()
                                bigImage = "po3"
                            } label: {
                                Image("y3")
                                    .resizable()
                                    .scaledToFit()
                            }
                            
                            Button {
                                isbigImage.toggle()
                                bigImage = "po4"
                            } label: {
                                Image("y4")
                                    .resizable()
                                    .scaledToFit()
                            }
                            
                        }
                        
                        
                        
        
                    }
                    .padding()
                } else if selectedSegment == 2 {
                    // Комментарии
                    ScrollView {
                        ForEach(commentsManager.getComments(for: category)) { comment in
                            VStack(alignment: .leading, spacing: 8) {
                                Text(comment.name)
                                    .font(.headline)
                                    .foregroundColor(.black)
                                Text(comment.message)
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(12)
                            .shadow(radius: 1)
                            .frame(maxWidth: .infinity, alignment: .leading) // Растягиваем на всю ширину
                            .padding(.horizontal, 16) // Отступы от краев экрана
                        }
                        
                    }
                    // Поля для ввода имени и комментария
                    VStack(spacing: 16) {
                        Text("Write comment")
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                        
                        // Поле для ввода имени
                        TextField("Your Name", text: $name)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal)
                        
                        // Поле для ввода сообщения
                        TextField("Your Message", text: $message)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal)
                        
                        // Кнопка для отправки комментария
                        Button(action: {
                            addComment()
                        }) {
                            Text("Send")
                                .foregroundColor(.white)
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.black)
                                .cornerRadius(25)
                                .padding(.horizontal)
                        }
                    }
                    .padding(.vertical)
                }
                
                
                Spacer()
            }
            .overlay(content: {
                if isbigImage {
                    VStack{
                        HStack{
                            Spacer()
                            Button(action: {
                                isbigImage.toggle()
                            }, label: {
                                Text("Closed").foregroundColor(.white)
                                    .font(.title3)
                            }).padding()
                        }
                        Image(bigImage)
                    }.frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.black)
                    
                    
                }
               
            })
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Image("hotels7").resizable().scaledToFill()) // Убедитесь, что изображение существует
            .ignoresSafeArea()
            .fullScreenCover(isPresented: $booking, content: {
                BookingView(img: "hotels7", title: "Loews Hotel Vogue")
            })
        }
    }
    
    private func addComment() {
        guard !name.isEmpty, !message.isEmpty else { return } // Проверка на заполненность полей
        commentsManager.addComment(for: category, name: name, message: message) // Добавление комментария в менеджер
        name = ""   // Сброс поля имени
        message = "" // Сброс поля сообщения
    }
}

#Preview {
    Hotel7View().environmentObject(CommentsManager())
}
