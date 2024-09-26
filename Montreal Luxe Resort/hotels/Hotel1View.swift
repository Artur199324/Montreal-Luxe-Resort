import SwiftUI

struct Hotel1View: View {
    @EnvironmentObject var commentsManager: CommentsManager
    let category: String = "hotel1"
    @State private var name: String = ""
    @State private var message: String = ""
    @Environment(\.dismiss) var dismiss
    @State private var selectedSegment = 0
    private let segments = ["Description", "Photos"]
    @State var booking = false
    @State var isbigImage = false
    @State var bigImage = "mo1"
    
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
                            Text("Montreal Casino")
                                .font(.title)
                                .padding()
                            Text("The Casino de Montréal is the best casino in Montreal… because it’s the only one actually in the city. But it’s a beautiful venue that was designed for Expo 67 and later turned into a casino, so it’s got that mid-century architecture vibe.\n \nThe casino has been renovated and expanded fairly recently, which made room for a lot more slot machines, as well as entertainment venues. There’s a theatre with shows (some dinner shows) and a dance floor and bar with live music every evening. So even if you don’t want to play the slots, there are plenty of things for you to enjoy.")
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
                                bigImage = "mo1"
                            } label: {
                                Image("im1")
                                    .resizable()
                                    .scaledToFit()
                            }

                            Button {
                                isbigImage.toggle()
                                bigImage = "mo2"
                            } label: {
                                Image("im2")
                                    .resizable()
                                    .scaledToFit()
                            }

            
                        }
                        HStack {
                            Button {
                                isbigImage.toggle()
                                bigImage = "mo3"
                            } label: {
                                Image("im3")
                                    .resizable()
                                    .scaledToFit()
                            }
                            
                            Button {
                                isbigImage.toggle()
                                bigImage = "mo4"
                            } label: {
                                Image("im4")
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
            .background(Image("hotels1").resizable().scaledToFill()) // Убедитесь, что изображение существует
            .ignoresSafeArea()
            .fullScreenCover(isPresented: $booking, content: {
                BookingView(img: "hotels1", title: "Montreal Casino")
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
    Hotel1View()
        .environmentObject(CommentsManager()) // Убедитесь, что CommentsManager передан через окружение
}
