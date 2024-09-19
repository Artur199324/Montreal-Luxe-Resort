import SwiftUI
import CoreData

struct InterestingView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss

    @State private var isAddFact = false
    @FetchRequest(
        entity: Fact.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Fact.title, ascending: true)]
    ) var facts: FetchedResults<Fact>

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button(action: {
                        self.dismiss()
                    }, label: {
                        Image("tabler-icon-arrow-narrow-left")
                    })
                    .padding(.leading, 20)
                    
                    Text("Interesting")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.leading, 10)
                    
                    Spacer()
                }
                .padding(.top, 50)

                ScrollView {
                    LazyVStack(spacing: 20) {
                        ForEach(facts, id: \.id) { fact in
                            NavigationLink(destination: FactDetailView(fact: fact)) {
                                CardView(fact: fact)
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 60)
                    .padding(.bottom, 250)
                }
                
//                Button(action: {
//                    isAddFact.toggle()
//                }, label: {
//                    Image("Frame 6")
//                })
//                .padding(.bottom, 50)
               
            }
            .background(Image("interesting"))
            .ignoresSafeArea()
            .fullScreenCover(isPresented: $isAddFact, content: {
                AddFactView()
            })
            .onAppear {
                addDefaultFactsIfNeeded()
            }
        }
    }

    // Функция для добавления двух фактов по умолчанию, если база данных пуста
    private func addDefaultFactsIfNeeded() {
        // Проверяем, есть ли уже факты в базе данных
        if facts.isEmpty {
            let fact1 = Fact(context: viewContext)
            fact1.id = UUID()
            fact1.title = "Montreal Casino’s Unique Architecture"
            fact1.text = "The Montreal Casino is housed in a set of buildings with distinctive architecture. One of its main structures was originally built for Expo 67, the international exposition held in Montreal.\nThe most recognizable building is the former French Pavilion, a futuristic design with a complex, multi-level structure. The casino’s architecture features multiple layers of glass and sharp angles, making it a modernist masterpiece.\n Visitors can enjoy sweeping views of the St. Lawrence River and the city skyline from the casino. The casino has five floors, each connected by spiral staircases and escalators. Inside, there’s an abundance of natural light, thanks to large windows throughout the venue./n This gives the casino an open and airy atmosphere, different from the dimly lit environment often associated with casinos. In addition to the gaming areas, the architecture creates a striking backdrop for various performances and shows./n Overall, its futuristic design makes it one of the most visually captivating casinos in the world."
            if let image = UIImage(named: "Group 7"), let imageData = image.pngData() {
                fact1.photo = imageData
            }

            let fact2 = Fact(context: viewContext)
            fact2.id = UUID()
            fact2.title = "A World-Class Entertainment Destination"
            fact2.text = "Montreal Casino is not just about gambling; it’s also a hub for entertainment and dining. It boasts three high-end restaurants offering diverse culinary experiences, from gourmet French cuisine to casual bistro dining.\n  The casino is also home to several bars and lounges, where visitors can enjoy live music and performances.\nThe famous Cabaret du Casino features regular shows with a variety of performances, including musical acts, comedy shows, and theatrical productions.\nThe casino offers over 3,000 slot machines and more than 100 gaming tables, providing endless opportunities for fun. One unique feature is that the casino operates 24 hours a day, 7 days a week, ensuring that entertainment is always available.\nSpecial events, like poker tournaments and themed nights, keep the atmosphere lively. For those who prefer non-gambling activities, the casino offers art exhibitions and special culinary events./nAll these elements combined make the Montreal Casino a world-class destination that appeals to both gamblers and non-gamblers alike."
            if let image = UIImage(named: "Group 77"), let imageData = image.pngData() {
                fact2.photo = imageData
            }

            do {
                try viewContext.save() // Сохраняем изменения в контексте
            } catch {
                let nsError = error as NSError
                fatalError("Не удалось сохранить факты по умолчанию \(nsError), \(nsError.userInfo)")
            }
        }
    }

  
}

#Preview {
    InterestingView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
