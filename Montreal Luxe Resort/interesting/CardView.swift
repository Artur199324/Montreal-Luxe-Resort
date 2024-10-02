import SwiftUI

struct CardView: View {
    let fact: Fact

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            if let imageData = fact.photo, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 200)
                    .clipped()
                    .cornerRadius(10)
//                    .overlay(
//                        HStack {
//                            Spacer()
//                            Button(action: {
//                                // Действие на иконку избранного
//                            }) {
//                                Image(systemName: "heart.fill")
//                                    .padding(10)
//                                    .background(Color.white.opacity(0.7))
//                                    .clipShape(Circle())
//                                    .padding([.top, .trailing], 10)
//                            }
//                        }
//                    )
            }

            VStack(alignment: .leading) {
                Text(fact.title ?? "Без названия")
                    .font(.headline)
                    .foregroundColor(.white)
//                Text(fact.text ?? "Описание отсутствует")
//                    .font(.subheadline)
//                    .foregroundColor(.secondary)
                
                HStack {
                    Spacer()
                   
                }
            }
            .padding([.leading, .bottom, .trailing], 10)
        }
        .background(Color("bac"))
        .cornerRadius(15)
        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 5)
    }
}

#Preview {
    CardView(fact: Fact(context: PersistenceController.preview.container.viewContext))
        .previewLayout(.sizeThatFits)
        .padding()
}
