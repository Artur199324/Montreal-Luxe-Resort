import SwiftUI

struct ContentView: View {
    @AppStorage("isEULAAccepted") private var isEULAAccepted: Bool = false
    @State private var isWelcome = false
   
    var body: some View {
        if isEULAAccepted {
            VStack {
                Spacer()
                
                // Проверяем, если таймер истек, показываем кнопку
               
                    Button(action: {
                        isWelcome.toggle()
                    }, label: {
                        Image("Frame 5")
                    })
                    .padding(.bottom, 20)
               
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Image("onboarding").ignoresSafeArea())
         
            .fullScreenCover(isPresented: $isWelcome) {
                WelcomeView()
            }
         
        } else {
            EULAScreen()
        }
    }
}

#Preview {
    ContentView()
}
