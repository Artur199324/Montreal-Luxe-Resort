import SwiftUI

struct EULAScreen: View {
    @State private var isAgreed = false
    @State private var showRefusalMessage = false
    @AppStorage("isEULAAccepted") private var isEULAAccepted: Bool = false

    var body: some View {
        VStack(spacing: 20) {
            Text("End User License Agreement")
                .font(.largeTitle)
                .padding()

            ScrollView {
                Text("""
                    1. General Provisions
                    By using the Montreal Luxe Resort application (“Application”), you agree to these terms. If you do not agree, please discontinue using the Application.

                    2. License
                    We grant you the right to use the Application for personal purposes. You may not copy, modify, or distribute the Application without permission.

                    3. Prohibited Content
                    It is prohibited to use the Application to create or store content that is offensive, threatening, discriminatory, or infringes on the rights of others.

                    4. Responsibility
                    You are responsible for your comments. We may restrict access to the Application for violating these terms.

                    5. Changes
                    We may update these terms. By continuing to use the Application after updates, you agree to the new terms.
                    """)
                    .padding()
            }

            Toggle(isOn: $isAgreed) {
                Text("I have read and agree to the terms")
            }
            .padding()

            HStack {
                Button(action: {
                    showRefusalMessage = true
                }) {
                    Text("Decline")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }

                Button(action: {
                    if isAgreed {
                        isEULAAccepted = true
                    }
                }) {
                    Text("Accept")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(isAgreed ? Color.blue : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .disabled(!isAgreed)
            }
            .padding()

            if showRefusalMessage {
                Text("You cannot use the application if you do not accept the terms. Please contact support for more information.")
                    .foregroundColor(.red)
                    .padding()
            }
        }
        .padding()
    }
}

#Preview {
    EULAScreen()
}
