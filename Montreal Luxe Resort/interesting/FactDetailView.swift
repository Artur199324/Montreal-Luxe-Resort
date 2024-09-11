import SwiftUI
import CoreData

struct FactDetailView: View {
    let fact: Fact

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Отображаем изображение из базы данных
                if let imageData = fact.photo, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity, maxHeight: 300)
                        .cornerRadius(15)
                        .padding([.leading, .trailing], 16)
                } else {
                    // Показать изображение-заполнитель, если фото отсутствует
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, maxHeight: 200)
                        .foregroundColor(.gray)
                        .padding([.leading, .trailing], 16)
                }

                // Отображаем заголовок факта
                Text(fact.title ?? "Без названия")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .padding([.leading, .trailing], 16)

                // Отображаем основной текст факта
                Text(fact.text ?? "Описание отсутствует")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .padding([.leading, .trailing], 16)
                
                Spacer()
            }
            .padding(.top, 16)
        }
        
            .background(Color("bac"))
        .navigationTitle("Details of the fact")
    }
}

#Preview {
    // Создаём пример данных для предпросмотра
    let context = PersistenceController.preview.container.viewContext
    let fact = Fact(context: context)
    fact.title = "Montreal Casino’s Unique Architecture"
    fact.text = """
    The Montreal Casino is housed in a set of buildings with distinctive architecture. One of its main structures was originally built for Expo 67, the international exposition held in Montreal.

    The most recognizable building is the former French Pavilion, a futuristic design with a complex, multi-level structure. The casino’s architecture features multiple layers of glass and sharp angles, making it a modernist masterpiece.

    Visitors can enjoy sweeping views of the St. Lawrence River and the city skyline from the casino. The casino has five floors, each connected by spiral staircases and escalators. Inside, there’s an abundance of natural light, thanks to large windows.
    """
    fact.photo = UIImage(named: "exampleImage")?.pngData() // Примерное изображение

    return FactDetailView(fact: fact)
        .environment(\.managedObjectContext, context)
        .previewLayout(.sizeThatFits)
}
