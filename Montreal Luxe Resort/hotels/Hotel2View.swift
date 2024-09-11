//
//  Hotel2View.swift
//  Montreal Luxe Resort
//
//  Created by Artur on 11.09.2024.
//

import SwiftUI

struct Hotel2View: View {
    @EnvironmentObject var commentsManager: CommentsManager
    let category: String = "hotel2"
    @State private var name: String = ""
    @State private var message: String = ""
    @Environment(\.dismiss) var dismiss
    @State private var selectedSegment = 0
    private let segments = ["Description", "Photos", "Comments"]
    
    var body: some View {
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
                        Text("Le Germain Hotel Montreal")
                            .font(.title)
                            .padding()
                        Text("Built in 1967, the year of the Expo, in the heart of downtown, Le Germain Hotel Montreal is certain to become your hotel of choice. Experience the charm of a modern reinterpretation of sixties-inspired décor and take advantage of the hotel’s convenient location, ideal for both business and pleasure.\n \nJust steps away from many boutiques, museums, businesses and restaurants and a pleasant stroll from the sensational festivals and events of Quartier des Spectacles, Le Germain Hotel Montreal is your oasis of tranquility in the heart of the action. Whether for business or pleasure, it’s the perfect location")
                            .padding(.horizontal)
                        Image("Frame 32")
                            .resizable()
                            .scaledToFit()
                            .padding()
                    }
                }
            } else if selectedSegment == 1 {
                // Фотографии отеля
                VStack {
                    HStack {
                        Image("q1")
                            .resizable()
                            .scaledToFit()
                        Image("q2")
                            .resizable()
                            .scaledToFit()
                    }
                    HStack {
                        Image("q3")
                            .resizable()
                            .scaledToFit()
                        Image("q4")
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
        .background(Image("hotels2").resizable().scaledToFill()) // Убедитесь, что изображение существует
        .ignoresSafeArea()
    }
    
    private func addComment() {
        guard !name.isEmpty, !message.isEmpty else { return } // Проверка на заполненность полей
        commentsManager.addComment(for: category, name: name, message: message) // Добавление комментария в менеджер
        name = ""   // Сброс поля имени
        message = "" // Сброс поля сообщения
    }
}

#Preview {
    Hotel2View().environmentObject(CommentsManager())
}
