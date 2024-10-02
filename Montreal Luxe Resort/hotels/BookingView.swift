import SwiftUI
import FirebaseCore
import Firebase
import FirebaseFirestore
struct BookingView: View {
    @State var img:String
    @State  var title:String
    @Environment(\.dismiss) var dismiss
    @State private var selectedStartDate: Date?
    @State private var selectedEndDate: Date?
    @State private var selectedMonth = Calendar.current.component(.month, from: Date())
    @State private var selectedYear = Calendar.current.component(.year, from: Date())
    @State private var numberOfAdults = 2
    @State private var numberOfChildren = 1
    @State private var ok = true
    @State private var thenk = false
    @State private var dat = ""
    private let calendar = Calendar.current
    private let years = Array(2020...2030)
    private let months = Array(1...12)
    @State private var showAlert = false
    @State private var phoneNumber: String = ""
    @State private var name: String = ""  // Поле для ввода имени
    //       @State private var showAlertName = false
    @State private var alertMessage = ""
    
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                VStack{
                    HStack {
                        Button(action: {
                            self.dismiss()
                        }, label: {
                            Image("tabler-icon-arrow-narrow-left 1")
                        }).padding(.leading,30)
                        Text(title)
                            .foregroundColor(.white)
                            .font(.title2)
                            .padding(.leading,10)
                        Spacer()
                    }
                    
                    if ok {
                        VStack(spacing: 20) {
                            
                            HStack {
                                Button(action: {
                                    // Previous month action
                                    changeMonth(by: -1)
                                }) {
                                    Image(systemName: "chevron.left")
                                        .foregroundColor(.white)
                                }
                                
                                Spacer()
                                
                                Text("\(monthName(month: selectedMonth)) \(selectedYear)")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                
                                Spacer()
                                
                                Button(action: {
                                    // Next month action
                                    changeMonth(by: 1)
                                }) {
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.white)
                                }
                                
                                Spacer()
                                
                                Button("Clear") {
                                    selectedStartDate = nil
                                    selectedEndDate = nil
                                }
                                .foregroundColor(.white)
                            }
                            .padding(.horizontal)
                            
                            // Custom Calendar View
                            CalendarView(selectedStartDate: $selectedStartDate, selectedEndDate: $selectedEndDate, month: selectedMonth, year: selectedYear)
                            
                            // Adults stepper
                            HStack {
                                Text("Adults")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                Spacer()
//                                Stepper(value: $numberOfAdults, in: 1...10) {
//                                    Text("\(numberOfAdults)")
//                                        .font(.subheadline)
//                                        .foregroundColor(.white)
//                                }
                                CustomStepper(value: $numberOfAdults, range: 1...10)
                            }
                            .padding(.horizontal)
                            
                            // Children stepper
                            HStack {
                                Text("Children")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                Spacer()
                                CustomStepper(value: $numberOfChildren, range: 1...10)
                              
                            }
                            .padding(.horizontal)
                            
                            ZStack(alignment: .leading) {
                                if name.isEmpty {
                                    Text("Your Name")
                                        .foregroundColor(.white)  // Цвет плейсхолдера
                                        .padding(.horizontal, 30)
                                }
                                
                                TextField("", text: $name)
                                    .padding()
                                    .foregroundColor(.white)  // Цвет текста, который вводит пользователь
                                    .background(Color("col4").opacity(0.7))
                                    .cornerRadius(10)
                                    .padding(.horizontal, 24)
                            }  // Цвет плейсхолдера

                            
                            // Поле для ввода номера телефона
                            ZStack(alignment: .leading) {
                                if phoneNumber.isEmpty {
                                    Text("Phone Number")
                                        .foregroundColor(.white)  // Цвет плейсхолдера
                                        .padding(.horizontal, 30)
                                }
                                
                                TextField("", text: $phoneNumber)
                                    .keyboardType(.numberPad) // Используем цифровую клавиатуру
                                    .padding()
                                    .foregroundColor(.white)  // Цвет текста, который вводит пользователь
                                    .background(Color("col4").opacity(0.7))
                                    .cornerRadius(10)
                                    .padding(.horizontal, 24)
                                    .onChange(of: phoneNumber) { oldValue, newValue in
                                        // Оставляем только цифры в строке
                                        phoneNumber = newValue.filter { "0123456789".contains($0) }
                                    }
                            }

                            
                            // Book Now button
                            Button(action: {
                                bookNow()
                            }) {
                                Image("buynow")
                            }
                            .padding(.horizontal)
                            .padding(.top, 10)
                            Image("You will be called back to the number you provided!").padding(.top,30)
                            
                        }
                        .padding(.vertical)
                        .background(Color(UIColor(hex: "#1A0D70")))
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,maxHeight: .infinity)
                        Spacer()
                    }else{
                        VStack(spacing: 20) {
                            Image("Please check that your information is correct").padding(.top,20)
                            HStack{
                                Image("Name").padding(.leading,20)
                                Spacer()
                                Text(name).padding(.trailing,20)
                                    .foregroundColor(.white)
                            }.padding(.top,20)
                            HStack{
                                Image("Phone").padding(.leading,20)
                                Spacer()
                                Text(phoneNumber).padding(.trailing,20)
                                    .foregroundColor(.white)
                            }.padding(.top,20)
                            HStack{
                                Image("Dates").padding(.leading,20)
                                    .foregroundColor(.white)
                                Spacer()
                                Text(dat).padding(.trailing,20)
                                    .foregroundColor(.white)
                            }.padding(.top,20)
                            HStack{
                                Image("Adults").padding(.leading,20)
                                Spacer()
                                Text("\(numberOfAdults)").padding(.trailing,20)
                                    .foregroundColor(.white)
                            }.padding(.top,20)
                            HStack{
                                Image("Children").padding(.leading,20)
                                Spacer()
                                Text("\(numberOfChildren)").padding(.trailing,20)
                                    .foregroundColor(.white)
                            }.padding(.top,20)
                            
                            HStack{
                                Button {
                                    ok.toggle()
                                } label: {
                                    Image("baccc")
                                }
                                
                                Button(action: {
                                    savePhoneNumberAndName()
                                    thenk.toggle()
                                }, label: {
                                    Image("coo")
                                })
                            }.padding(.top,30)
                            
                            Spacer()
                        } .padding(.vertical)
                            .background(Color(UIColor(hex: "#1A0D70")))
                        
                    }
                }
                
            }.overlay(content: {
                if thenk {
                    VStack{
                        
                        Image("Frame 70").overlay {
                            Button(action: {
                                self.dismiss()
                            }, label: {
                                Image("ok 1").padding(.top,300)
                            })
                        }
                        
                        
                    }.frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.8))}
                
                
                
                
            })
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Image(img).resizable().scaledToFill())
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Booking Info"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
            
        }
    }
    
    // Function to get the month name
    private func monthName(month: Int) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        return dateFormatter.monthSymbols[month - 1]
    }
    
    // Function to change the month
    private func changeMonth(by value: Int) {
        var dateComponents = DateComponents()
        dateComponents.month = value
        if let newDate = calendar.date(byAdding: dateComponents, to: calendar.date(from: DateComponents(year: selectedYear, month: selectedMonth))!) {
            selectedMonth = calendar.component(.month, from: newDate)
            selectedYear = calendar.component(.year, from: newDate)
        }
    }
    
    // Function to handle booking action
    private func bookNow() {
        // Проверяем, что введены и имя, и номер телефона
        guard !phoneNumber.isEmpty, !name.isEmpty else {
            alertMessage = "Please enter both name and phone number."
            showAlert = true  // Показываем алерт для имени и телефона
            return
        }
        
        // Проверяем, что выбраны обе даты: стартовая и конечная
        if let startDate = selectedStartDate, let endDate = selectedEndDate {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            
            // Форматируем строки для начала и конца периода бронирования
            let startString = dateFormatter.string(from: startDate)
            let endString = dateFormatter.string(from: endDate)
            
            dat = "Booking from \(startString) to \(endString)"
            print("Booking from \(startString) to \(endString) in \(monthName(month: selectedMonth)) \(selectedYear)")
           
            ok.toggle()  // Успешная обработка, переход к другому состоянию
        } else {
            // Если даты не выбраны, показываем алерт
            alertMessage = "Please select a start and end date."
            showAlert = true  // Показ алерта, если не выбраны даты
        }
    }
    
    private func savePhoneNumberAndName() {
            let db = Firestore.firestore()  // Инициализация Firestore
            
            // Проверка, что имя и номер телефона введены
           
            
            let userData: [String: Any] = [
                "name": name,  // Имя пользователя
                "phoneNumber": phoneNumber,  // Номер телефона
                "timestamp": Timestamp(date: Date())  // Метка времени
            ]
            
            // Сохранение данных в коллекцию "phoneNumbers"
            db.collection("phoneNumbers").addDocument(data: userData) { error in
                if let error = error {
                    // Отображение сообщения об ошибке
                    alertMessage = "Error saving data: \(error.localizedDescription)"
                    showAlert = true
                }
               
            }
        }
    }



struct CalendarView: View {
    @Binding var selectedStartDate: Date?
    @Binding var selectedEndDate: Date?
    
    let month: Int
    let year: Int
    private let calendar = Calendar.current
    
    var body: some View {
        let dates = generateDates(for: month, year: year)
        
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7)) {
            ForEach(dates, id: \.self) { date in
                Text(dateDisplayText(for: date))
                    .font(.headline)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(backgroundColor(for: date))
                    .foregroundColor(foregroundColor(for: date))
                    .clipShape(Circle())
                    .onTapGesture {
                        handleDateSelection(date: date)
                    }
                    .disabled(isDateInPast(date)) // Disable past dates
                    .opacity(isDateInPast(date) ? 0.3 : 1.0) // Dim past dates
            }
        }
    }
    
    private func generateDates(for month: Int, year: Int) -> [Date] {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = 1
        
        guard let startOfMonth = calendar.date(from: components),
              let range = calendar.range(of: .day, in: .month, for: startOfMonth) else { return [] }
        
        return range.compactMap { day -> Date? in
            return calendar.date(byAdding: .day, value: day - 1, to: startOfMonth)
        }
    }
    
    private func dateDisplayText(for date: Date) -> String {
        let day = calendar.component(.day, from: date)
        return "\(day)"
    }
    
    private func backgroundColor(for date: Date) -> Color {
        if isSelectedDate(date) {
            return Color.blue
        } else if isInRange(date) {
            return Color("col1")
        } else {
            return Color.clear
        }
    }
    
    private func foregroundColor(for date: Date) -> Color {
        return isDateInPast(date) ? Color.gray : (isSelectedDate(date) ? Color.white : Color.white)
    }
    
    private func isSelectedDate(_ date: Date) -> Bool {
        return calendar.isDate(date, inSameDayAs: selectedStartDate ?? Date.distantPast) ||
               calendar.isDate(date, inSameDayAs: selectedEndDate ?? Date.distantPast)
    }
    
    private func isInRange(_ date: Date) -> Bool {
        guard let start = selectedStartDate, let end = selectedEndDate else { return false }
        return date >= start && date <= end
    }
    
    private func isDateInPast(_ date: Date) -> Bool {
        return date < Date()
    }
    
    private func handleDateSelection(date: Date) {
        guard !isDateInPast(date) else { return }
        
        if selectedStartDate == nil || selectedEndDate != nil {
            // Select start date or reset selection
            selectedStartDate = date
            selectedEndDate = nil
        } else if let startDate = selectedStartDate, date >= startDate {
            // Select end date
            selectedEndDate = date
        }
    }
    
}
extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        let alpha = hexSanitized.count == 8 ? CGFloat((rgb & 0xFF000000) >> 24) / 255.0 : 1.0

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
struct BookingView_Previews: PreviewProvider {
    static var previews: some View {
        BookingView(img: "hotels1", title: "Montreal Casino")
    }
}
