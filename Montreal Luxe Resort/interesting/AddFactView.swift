//
//  AddFactView.swift
//  Montreal Luxe Resort
//
//  Created by Artur on 11.09.2024.
//

import SwiftUI

struct AddFactView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var title: String = ""
    @State private var text: String = ""
    @State private var selectedImage: UIImage?
    @State private var showImagePicker: Bool = false
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    self.dismiss()
                }, label: {
                    Image("tabler-icon-arrow-narrow-left 1")
                })
                .padding(.leading, 20)
                
                Image("Frame 10")
                    .padding(.leading, 10)
                
                Spacer()
            }
            .padding(.top, 50)
         
            HStack{
                VStack{
                    Text("Photos")
                        .padding(.top,16)
                        .padding(.leading,16)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Button(action: {
                        showImagePicker = true
                    }) {
                        if let image = selectedImage {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                        } else {
                            Image("Frame 34")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                            
                        }
                    }
                    .padding(.leading,16)
                
                    .sheet(isPresented: $showImagePicker) {
                        ImagePicker(image: $selectedImage)
                    }
                    
                }
            Spacer()
        }
            
            VStack(alignment: .leading) {
                            Text("Title")
                                .font(.caption)
                                .foregroundColor(.secondary)
                                .padding(.leading, 16)
                            
                            TextField("Enter Title", text: $title)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                                )
                                .padding(.horizontal, 16)
                        }
                        .padding(.top, 16)
                        
                        // Поле ввода основного текста
                        VStack(alignment: .leading) {
                            Text("Main Text")
                                .font(.caption)
                                .foregroundColor(.secondary)
                                .padding(.leading, 16)
                            
                            TextEditor(text: $text)
                                .frame(height: 150)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                                )
                                .padding(.horizontal, 16)
                        }
                        .padding(.top, 16)
            
        
            Button(action: {
                if validateInputs() {
                    saveFact()
                }
            }, label: {
                Image("Frame 7")
            })
            .padding()
//            .disabled(!validateInputs()) // Блокировка кнопки, если данные не валидны
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("ОК")))
            }
            
            Spacer()
            
        }.frame(maxWidth: .infinity,maxHeight: .infinity)
            .background(Color("bac")).ignoresSafeArea()
        
        
    }
    
    // Проверка ввода
    private func validateInputs() -> Bool {
        if title.isEmpty {
            alertMessage = "Please enter a title."
            showAlert = true
            return false
        }
        if text.isEmpty {
            alertMessage = "Please enter text."
            showAlert = true
            return false
        }
        if selectedImage == nil {
            alertMessage = "Please select an image."
            showAlert = true
            return false
        }
        return true
    }

    // Сохранение факта в Core Data
    private func saveFact() {
        withAnimation {
            let newFact = Fact(context: viewContext)
            newFact.id = UUID()
            newFact.title = title
            newFact.text = text
            if let image = selectedImage, let imageData = image.pngData() {
                newFact.photo = imageData
            }
            do {
                try viewContext.save()
                self.dismiss()
            } catch {
                let nsError = error as NSError
                fatalError("Не удалось сохранить данные \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

#Preview {
    AddFactView()
}
