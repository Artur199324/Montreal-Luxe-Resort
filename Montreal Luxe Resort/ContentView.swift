import SwiftUI

struct ContentView: View {
    @AppStorage("isEULAAccepted") private var isEULAAccepted: Bool = false
    @State private var isWelcome = false
    @State private var shouldShowButton = false // Переменная для управления видимостью кнопки
    @State private var isTerms = false
    @State private var isPolisi = false
    var body: some View {
        if isEULAAccepted {
            VStack {
                Spacer()
                
                // Проверяем, если таймер истек, показываем кнопку
                if shouldShowButton {
                    Button(action: {
                        isWelcome.toggle()
                    }, label: {
                        Image("Frame 5")
                    })
                    .padding(.bottom, 20)
                }else{
                    RotatingProgressBar().padding(.bottom,20)
                    HStack(spacing:40){
                        Button(action: {
                            isTerms.toggle()
                        }, label: {
                            Image("ter")
                        })
                            
                        Button(action: {
                            isPolisi.toggle()
                        }, label: {
                            Image("priv")
                        })
                    }.padding(.bottom,20)
                }
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Image(shouldShowButton ? "onboarding" : "launch").ignoresSafeArea())
            .onAppear {
                // Запуск таймера на 4 секунды
                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                    shouldShowButton = true
                }
            }
            .fullScreenCover(isPresented: $isWelcome) {
                WelcomeView()
            }
            .fullScreenCover(isPresented: $isTerms, content: {
                TermsofUseView()
            })
            .fullScreenCover(isPresented: $isPolisi, content: {
                PrivacyPolicyView()
            })
        } else {
            EULAScreen()
        }
    }
}

#Preview {
    ContentView()
}
