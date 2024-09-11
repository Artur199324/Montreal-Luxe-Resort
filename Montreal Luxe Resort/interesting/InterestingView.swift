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
                
                Button(action: {
                    isAddFact.toggle()
                }, label: {
                    Image("Frame 6")
                })
                .padding(.bottom, 50)
               
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
            fact1.text = "This is the first default fact with some interesting details."
            if let image = UIImage(named: "Group 7"), let imageData = image.pngData() {
                fact1.photo = imageData
            }

            let fact2 = Fact(context: viewContext)
            fact2.id = UUID()
            fact2.title = "A World-Class Entertainment Destination"
            fact2.text = "This is the second default fact with more interesting details."
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
