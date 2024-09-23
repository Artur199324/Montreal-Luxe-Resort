//
//  Hotel4View.swift
//  Montreal Luxe Resort
//
//  Created by Artur on 11.09.2024.
//

import SwiftUI

struct Hotel4View: View {
    @EnvironmentObject var commentsManager: CommentsManager
    let category: String = "hotel4"
    @State private var name: String = ""
    @State private var message: String = ""
    @Environment(\.dismiss) var dismiss
    @State private var selectedSegment = 0
    private let segments = ["Description", "Photos"]
    
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
                        Text("Fairmont The Queen Elizabeth")
                            .font(.title)
                            .padding()
                        Text("Under the watchful eye of the Mont Royal expands romantic and cosmopolitan Montreal, where English and French cultures meet in harmony. With stellar restaurant options and activites aplenty, you are sure to never go hungry or bored in our wonderful city.\n\nPerfectly located in the heart of downtown, Fairmont The Queen Elizabeth has a fascinating history that unravels through a \"for Montrealers, by Montrealers\" concept featuring a restaurant, a bar, an urban market and a coffee shop where local products and talents take the center stage. \n\n As you will definitely want to stay longer, our hotel offers accommodations perfectly elaborated to fit your stay. From couples' retreats to action-packed family vacations, your stay with us means making memories that you will forever cherish..")
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
                        Image("e1")
                            .resizable()
                            .scaledToFit()
                        Image("e2")
                            .resizable()
                            .scaledToFit()
                    }
                    HStack {
                        Image("e3")
                            .resizable()
                            .scaledToFit()
                        Image("e4")
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
        .background(Image("hotels4").resizable().scaledToFill()) // Убедитесь, что изображение существует
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
    Hotel4View().environmentObject(CommentsManager())
}
