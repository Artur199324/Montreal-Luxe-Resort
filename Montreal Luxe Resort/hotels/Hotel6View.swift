//
//  Hotel6View.swift
//  Montreal Luxe Resort
//
//  Created by Artur on 11.09.2024.
//

import SwiftUI

struct Hotel6View: View {
    @EnvironmentObject var commentsManager: CommentsManager
    let category: String = "hotel6"
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
                        Text("Hotel Place d’Armes")
                            .font(.title)
                            .padding()
                        Text("Hotel Place d'Armes features 116 rooms and 53 suites, including six studios with private terrace and five large penthouses where the decor blends contemporary design with ancient architecture.\n\nThe 4 historic buildings housing Hotel Place d'Armes all date back to the late 19th century. These regal structures were originally home to some of the pre-eminent businesses of the time, and their architecture recalls an era devoted to unmatched craftsmanship and detail.\n\nHotel Features: - 7 meeting rooms and a modular ballroom that can accommodate up to 350 people, with natural light, stone or brick walls and equipped with comfortable furniture - 2 restaurants and a spa - Rooftop Terrace.")
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
                        Image("t1")
                            .resizable()
                            .scaledToFit()
                        Image("t2")
                            .resizable()
                            .scaledToFit()
                    }
                    HStack {
                        Image("t3")
                            .resizable()
                            .scaledToFit()
                        Image("t4")
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
        .background(Image("hotels6").resizable().scaledToFill()) // Убедитесь, что изображение существует
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
    Hotel6View().environmentObject(CommentsManager())
}
