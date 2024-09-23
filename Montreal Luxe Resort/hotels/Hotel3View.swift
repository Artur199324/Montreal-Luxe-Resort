//
//  Hotel3View.swift
//  Montreal Luxe Resort
//
//  Created by Artur on 11.09.2024.
//

import SwiftUI

struct Hotel3View: View {
    @EnvironmentObject var commentsManager: CommentsManager
    let category: String = "hotel3"
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
                        Text("Sofitel Montreal Golden Mile")
                            .font(.title)
                            .padding()
                        Text("Sofitel Montreal Golden Mile is conveniently located in the heart of the city ideal for business travelers and art lovers - at the foot of lush Mount Royal Park, next to the renowned McGill University and Montreal Museum of Fine Arts.\n\nEnjoy the masterful blend of minimalist design and warm sophistication at our luxury hotel embellished with Victorian accents from the estate of North American railroad pioneer William Cornelius Van Horne.\n\nChoose one of 241 elegant and stylish hotel rooms or 17 suites all featuring Sofitel's luxurious feathertop and duvet sleep system - SoBed. 258 rooms including 17 suites.")
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
                        Image("w1")
                            .resizable()
                            .scaledToFit()
                        Image("w2")
                            .resizable()
                            .scaledToFit()
                    }
                    HStack {
                        Image("w3")
                            .resizable()
                            .scaledToFit()
                        Image("w4")
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
        .background(Image("hotels3").resizable().scaledToFill()) // Убедитесь, что изображение существует
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
    Hotel3View().environmentObject(CommentsManager())
}
