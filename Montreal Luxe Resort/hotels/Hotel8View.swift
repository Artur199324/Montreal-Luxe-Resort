//
//  Hotel8View.swift
//  Montreal Luxe Resort
//
//  Created by Artur on 11.09.2024.
//

import SwiftUI

struct Hotel8View: View {
    @State var booking = false
    @EnvironmentObject var commentsManager: CommentsManager
    let category: String = "hotel8"
    @State private var name: String = ""
    @State private var message: String = ""
    @Environment(\.dismiss) var dismiss
    @State private var selectedSegment = 0
    private let segments = ["Description", "Photos"]
    
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
                            Text("Hotel Le Crystal")
                                .font(.title)
                                .padding()
                            Text("Vivez le dynamisme et le raffinement du Warwick Le Crystal – Montréal, un hôtel-boutique situé au cœur du centre-ville, à quelques pas de l’emblématique Centre-Bell.\n\nProfitez d’un excellent séjour dans l’une de ses suites spécialement conçues pour un confort accru dans des espaces baignés d’une lumière naturelle qui leur confèrent une ambiance apaisante.\n\nAlliant style chic et urbain, elles sont toutes équipées d’une cuisinette, d’un très grand lit et d’une douche à effet pluie! Et si vous recherchez une destination pour les réunions d’affaires au centre-ville, l’espace événementiel du Warwick Le Crystal – Montréal comprend neuf salles polyvalentes et lumineuses, dont une vaste salle de bal adaptée aux réceptions de gala et aux cocktails.")
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
                            Image("u1")
                                .resizable()
                                .scaledToFit()
                            Image("u2")
                                .resizable()
                                .scaledToFit()
                        }
                        HStack {
                            Image("u3")
                                .resizable()
                                .scaledToFit()
                            Image("u4")
                                .resizable()
                                .scaledToFit()
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
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Image("hotels8").resizable().scaledToFill()) // Убедитесь, что изображение существует
            .ignoresSafeArea()
            .fullScreenCover(isPresented: $booking, content: {
                BookingView(img: "hotels8", title: "Hotel Le Crystal")
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
    Hotel8View().environmentObject(CommentsManager())
}

