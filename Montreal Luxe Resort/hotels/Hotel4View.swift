//
//  Hotel4View.swift
//  Montreal Luxe Resort
//
//  Created by Artur on 11.09.2024.
//

import SwiftUI

struct Hotel4View: View {
    @State var booking = false
    @EnvironmentObject var commentsManager: CommentsManager
    let category: String = "hotel4"
    @State private var name: String = ""
    @State private var message: String = ""
    @Environment(\.dismiss) var dismiss
    @State private var selectedSegment = 0
    private let segments = ["Description", "Photos"]
    @State var isbigImage = false
    @State var bigImage = "lo1"
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
                
                HStack(spacing: 0) {
                    ForEach(Array(segments.enumerated()), id: \.offset) { index, segment in
                        Text(segment)
                            .font(.system(size: 16))  // Уменьшенный размер шрифта
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 10)  // Уменьшаем вертикальные отступы для уменьшения высоты
                            .padding(.horizontal, 1)  // Немного уменьшим горизонтальные отступы
                            .background(selectedSegment == index ? Color("col1") : Color.clear)  // Цвет фона для выбранного элемента
                            .foregroundColor(selectedSegment == index ? Color.white : Color.white )  // Цвет текста для выбранного элемента
                            .cornerRadius(10)
                            .onTapGesture {
                                selectedSegment = index  // Обновляем выбранный сегмент
                            }
                    }
                }
                .padding(.vertical, 5)  // Уменьшение общей высоты переключателя
                .background(Color("col2"))  // Фон для всего переключателя
                .cornerRadius(20)  // Скругление углов
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.purple.opacity(0.5), lineWidth: 2)  // Рамка вокруг переключателя
                )
                .padding(.horizontal, 16)
                .padding(.top, 300)
                
                if selectedSegment == 0 {
                    // Описание отеля
                    ScrollView {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Fairmont The Queen Elizabeth")
                                .foregroundColor(.white)
                                .font(.title)
                                .padding()
                            Text("Under the watchful eye of the Mont Royal expands romantic and cosmopolitan Montreal, where English and French cultures meet in harmony. With stellar restaurant options and activites aplenty, you are sure to never go hungry or bored in our wonderful city.\n\nPerfectly located in the heart of downtown, Fairmont The Queen Elizabeth has a fascinating history that unravels through a \"for Montrealers, by Montrealers\" concept featuring a restaurant, a bar, an urban market and a coffee shop where local products and talents take the center stage. \n\n As you will definitely want to stay longer, our hotel offers accommodations perfectly elaborated to fit your stay. From couples' retreats to action-packed family vacations, your stay with us means making memories that you will forever cherish..")
                                .foregroundColor(Color("col3"))
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
                                bigImage = "lo1"
                            } label: {
                                Image("e1")
                                    .resizable()
                                    .scaledToFit()
                            }
                            
                            Button {
                                isbigImage.toggle()
                                bigImage = "lo2"
                            } label: {
                                Image("e2")
                                    .resizable()
                                    .scaledToFit()
                            }
                            
                            
                        }
                        HStack {
                            Button {
                                isbigImage.toggle()
                                bigImage = "lo3"
                            } label: {
                                Image("e3")
                                    .resizable()
                                    .scaledToFit()
                            }
                            
                            Button {
                                isbigImage.toggle()
                                bigImage = "lo4"
                            } label: {
                                Image("e4")
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
            }.overlay(content: {
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
            .background(Image("hotels4").resizable().scaledToFill()) // Убедитесь, что изображение существует
            .ignoresSafeArea()
            .fullScreenCover(isPresented: $booking, content: {
                BookingView(img: "hotels4", title: "Fairmont The Queen Elizabeth")
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
    Hotel4View().environmentObject(CommentsManager())
}
