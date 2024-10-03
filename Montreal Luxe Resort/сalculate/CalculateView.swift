import SwiftUI

struct CalculateView: View {
    @Environment(\.dismiss) var dismiss
    @State var sgowDat1 = false
    @State var dat1 = "nil" // Переменная для сохранения форматированной даты
    @State var sgowDat2 = false
    @State var dat2 = "nil"
    @State var selection = "nil"
    @State private var selectedDate = Date()
    @State private var selectedDate2 = Date()
    @State private var currentMonth = Calendar.current.component(.month, from: Date())
    @State private var currentYear = Calendar.current.component(.year, from: Date())
    @State  var guests: String = ""
    @State private var selectedRoomType = "Luxe" // По умолчанию выбранный элемент
      let roomTypes = ["President", "Luxe", "Classic", "Standart"]
    @State var f1 = false
    @State var f2 = false
    @State var f3 = false
    @State var f4 = false
    @State var ok = false
    @State private var showingAlert = false
    @State var services = ""
    @State var total = 0
 
    var body: some View {
        VStack {
          
                HStack {
                    Button(action: {
                        self.dismiss()
                    }, label: {
                        Image("tabler-icon-arrow-narrow-left 1")
                    })
                    .padding(.leading, 20)
                    
                    Image("colll")
                        .padding(.leading, 10)
                    
                    Spacer()
                }
            if !ok{
                HStack {
                    Image("c1")
                    Spacer()
                }
                .padding(.top, 20)
                .padding()
                
                Button(action: {
                    sgowDat1.toggle()
                }, label: {
                    Image(dat1 == "nil" ? "d1d1" : "d2d2")
                }).overlay {
                    HStack {
                        Text(dat1 == "nil" ? "Select Date" : "\(dat1)")
                            .foregroundColor(.white)
                            .padding()
                        Spacer()
                    }
                }
                
                HStack {
                    Image("c2")
                    Spacer()
                }
                .padding(.top, 10)
                .padding()
                
                Button(action: {
                    sgowDat2.toggle()
                }, label: {
                    Image(dat2 == "nil" ? "d1d1" : "d2d2")
                }).overlay {
                    HStack {
                        Text(dat2 == "nil" ? "Select Date" : "\(dat2)")
                            .foregroundColor(.white)
                            .padding()
                        Spacer()
                    }
                }
                HStack {
                    Image("c3")
                    Spacer()
                } .padding(.top, 10)
                    .padding()
                TextField("", text: $guests)
                    .padding(.leading, 20)
                    .keyboardType(.numberPad)
                    .onChange(of: guests) {_, newValue in
                        guests = newValue.filter { $0.isNumber }
                    }
                    .background(Image("pppp"))
                    .padding()
                    .cornerRadius(10)
                    .foregroundColor(.white)
                    .font(.system(size: 18, weight: .bold))
                
                HStack {
                    Image("c4")
                    Spacer()
                } .padding(.top, 10)
                    .padding()
                Picker("Room Type", selection: $selectedRoomType) {
                    ForEach(roomTypes, id: \.self) { roomType in
                        Text(roomType)
                            .tag(roomType)
                        
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .frame(maxWidth: .infinity,maxHeight: 20)
                .padding()
                .background(Color("col2"))
                .cornerRadius(10)
                .foregroundColor(.white)
                .padding(.leading, 20)
                .padding(.trailing, 20)
                .padding(.top, 20)
                .foregroundColor(.white)
                
                
                HStack {
                    Image("c5")
                    Spacer()
                } .padding(.top, 10)
                    .padding()
                
                HStack{
                    Button {
                        services += " Wifi"
                        f1.toggle()
                    } label: {
                        Image(f1 ? "fff1":"ff1")
                    }
                    
                    Button {
                        f2.toggle()
                        services += " TV"
                    } label: {
                        Image(f2 ? "fff2":"ff2")
                    }
                    
                    Button {
                        f3.toggle()
                        services += " Сonditioner"
                    } label: {
                        Image(f3 ? "fff3":"ff3")
                    }
                    Button {
                        f4.toggle()
                        services += " Breakfast"
                    } label: {
                        Image(f4 ? "fff4":"ff4")
                    }
                    
                }
                
                Button {
                    if dat1 != "nil" && dat2 != "nil" && guests != "" && selection != "nil"{
                        total = calculateDaysBetween(startDate: selectedDate, endDate: selectedDate2, guests: guests, type: selectedRoomType, f1: f1, f2: f2, f3: f3, f4: f4)
                        ok.toggle()
                    }else{
                        showingAlert.toggle()
                    }
                } label: {
                    Image(dat1 != "nil" && dat2 != "nil" && guests != "" && selection != "nil" ? "calc2" : "calc1")
                }.padding(.top,10)
                    .alert(isPresented: $showingAlert) {
                                  Alert(
                                      title: Text("Please make a selection"),
                                      message: Text("You need to select all required fields before proceeding."),
                                      dismissButton: .default(Text("OK"))
                                  )
                              }
            }else{
                ScrollView{
                    VStack{
                        HStack{
                            Text("Check-in date").foregroundColor(Color("col1")).padding()
                            Spacer()
                            Text("\(dat1)").padding().foregroundColor(.white)
                        }
                        
                        HStack{
                            Text("Date of departure").foregroundColor(Color("col1")).padding()
                            Spacer()
                            Text("\(dat2)").padding().foregroundColor(.white)
                        }
                        
                        HStack{
                            Text("Guests").foregroundColor(Color("col1")).padding()
                            Spacer()
                            Text("\(guests)").padding().foregroundColor(.white)
                        }
                        HStack{
                            Text("Room Type").foregroundColor(Color("col1")).padding()
                            Spacer()
                            Text("\(selection)").padding().foregroundColor(.white)
                        }
                        
                        HStack{
                            Text("Add. services").foregroundColor(Color("col1")).padding()
                            Spacer()
                            Text("\(services)").padding().foregroundColor(.white)
                        }
                        
                        HStack{
                            Text("Total").foregroundColor(Color("col1")).padding()
                            Spacer()
                            Text("$\(total)").padding().foregroundColor(Color("col1"))
                        }
                        
                    }.background(Color("col2"))
                        .padding(.top,50)
                    
                    Button(action: {
                        ok.toggle()
                    }, label: {
                        Image("new")
                    }).padding(.top,120)
                }
                
            }
          
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Image("calculate").ignoresSafeArea())
        
        .overlay {
            if sgowDat1 {
                VStack {
                    HStack {
                        Image("Dates 1").padding()
                        Spacer()
                    }
                    
                    HStack {
                        Button(action: {
                            changeMonth(by: -1)
                        }) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.orange)
                        }
                        Spacer()
                        // Название месяца и года
                        Text("\(monthName(for: currentMonth)) \(currentYear)")
                            .font(.title)
                            .foregroundColor(.orange)
                        Spacer()
                        Button(action: {
                            changeMonth(by: 1)
                        }) {
                            Image(systemName: "chevron.right")
                                .foregroundColor(.orange)
                        }
                    }
                    .padding()
                    
                    // Кастомный календарь для выбора одной даты
                    CustomCalendarView(selectedDate: $selectedDate, currentMonth: currentMonth, currentYear: currentYear)
                        .padding()
                        .background(Color(hex: "#311100")) // Цвет фона календаря
                        .cornerRadius(10) // Скругленные углы
                    
                    // Показ выбранной даты
                    Text("Selected date: \(selectedDate, formatter: dateFormatter)")
                        .foregroundColor(.white) // Цвет текста с выбранной датой
                        .padding()
                }
                .background(Color(hex: "#311100")) // Цвет фона всей области
                .foregroundColor(.white)
            }
            
            if sgowDat2 {
                VStack {
                    HStack {
                        Image("Dates 1").padding()
                        Spacer()
                    }
                    
                    HStack {
                        Button(action: {
                            changeMonth(by: -1)
                        }) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.orange)
                        }
                        Spacer()
                        // Название месяца и года
                        Text("\(monthName(for: currentMonth)) \(currentYear)")
                            .font(.title)
                            .foregroundColor(.orange)
                        Spacer()
                        Button(action: {
                            changeMonth(by: 1)
                        }) {
                            Image(systemName: "chevron.right")
                                .foregroundColor(.orange)
                        }
                    }
                    .padding()
                    
                    // Кастомный календарь для выбора одной даты
                    CustomCalendarView(selectedDate: $selectedDate2, currentMonth: currentMonth, currentYear: currentYear)
                        .padding()
                        .background(Color(hex: "#311100")) // Цвет фона календаря
                        .cornerRadius(10) // Скругленные углы
                    
                    // Показ выбранной даты
                    Text("Selected date: \(selectedDate2, formatter: dateFormatter)")
                        .foregroundColor(.white) // Цвет текста с выбранной датой
                        .padding()
                }
                .background(Color(hex: "#311100")) // Цвет фона всей области
                .foregroundColor(.white)
            }
        }
        // Добавляем два разных слушателя изменений выбранной даты
        .onChange(of: selectedDate) {_, newDate in
            if sgowDat1 {
                dat1 = formatDate(newDate) // Сохраняем форматированную дату в переменную dat1
                print("Дата выбрана: \(dat1)")
                sgowDat1.toggle() // Закрываем выбор даты
            }
        }
        .onChange(of: selectedDate2) {_, newDate in
            if sgowDat2 {
                dat2 = formatDate(newDate) // Сохраняем форматированную дату в переменную dat2
                print("Дата выбрана: \(dat2)")
                sgowDat2.toggle() // Закрываем выбор даты
            }
        }
        .onChange(of: selectedRoomType) { _,newSelection in
                   // Слушатель выбора
                  selection = newSelection
               }
    }
    
    // Метод для изменения месяца
    func changeMonth(by value: Int) {
        if let newDate = Calendar.current.date(byAdding: .month, value: value, to: Calendar.current.date(from: DateComponents(year: currentYear, month: currentMonth))!) {
            currentMonth = Calendar.current.component(.month, from: newDate)
            currentYear = Calendar.current.component(.year, from: newDate)
        }
    }
    
    // Метод для получения имени месяца
    func monthName(for month: Int) -> String {
        let formatter = DateFormatter()
        let months = formatter.shortMonthSymbols
        return months?[month - 1] ?? ""
    }
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter
    }
    
    // Метод для форматирования даты в "Sep 28, 2024"
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy" // Формат "Sep 28, 2024"
        return formatter.string(from: date)
    }
}

// Hex color support
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (r, g, b) = ((int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (r, g, b) = (int >> 16, int >> 8 & 0xFF, int & 0xFF)
        default:
            (r, g, b) = (1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: 1
        )
    }
}

func calculateDaysBetween(startDate: Date, endDate: Date, guests: String, type: String, f1: Bool, f2: Bool, f3: Bool, f4: Bool) -> Int {
    var sum = 50
    let calendar = Calendar.current
    
    // Вычисляем количество дней между двумя датами
    let components = calendar.dateComponents([.day], from: startDate, to: endDate)
    let de = components.day ?? 0
    sum *= de
    if let intNumber = Int(guests) {
        sum *= intNumber
        print("Преобразованное число гостей: \(intNumber)")
    } else {
        print("Не удалось преобразовать строку в число.")
        sum *= 1 
    }

    // Увеличиваем стоимость в зависимости от типа номера
    switch type {
    case "President":
        sum *= 4
    case "Luxe":
        sum *= 3
    case "Classic":
        sum *= 2
    case "Standart":
        sum *= 1
    default:
        break
    }
    
    // Увеличиваем стоимость за дополнительные услуги
    if f1 { sum += 10 }
    if f2 { sum += 10 }
    if f3 { sum += 10 }
    if f4 { sum += 10 }
    
    return sum
}


// Кастомный календарь для выбора одной даты
struct CustomCalendarView: View {
    @Binding var selectedDate: Date
    var currentMonth: Int
    var currentYear: Int
    
    let columns = Array(repeating: GridItem(.flexible()), count: 7) // Для 7 дней недели
    let calendar = Calendar.current
    let days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    
    var body: some View {
        VStack {
            LazyVGrid(columns: columns) {
                ForEach(days, id: \.self) { day in
                    Text(day)
                        .foregroundColor(.white) // Белый цвет для дней недели
                }
                
                ForEach(daysInMonth(for: currentMonth, year: currentYear), id: \.self) { date in
                    Text("\(calendar.component(.day, from: date))")
                        .foregroundColor(calendar.isDate(date, inSameDayAs: selectedDate) ? .black : .white) // Белый для всех, черный для выбранной даты
                        .padding(5)
                        .background(calendar.isDate(date, inSameDayAs: selectedDate) ? Color.orange : Color.clear)
                        .cornerRadius(8)
                        .onTapGesture {
                            selectedDate = date
                        }
                }
            }
        }
    }
    
    // Метод для получения всех дней в текущем месяце
    func daysInMonth(for month: Int, year: Int) -> [Date] {
        var components = DateComponents()
        components.month = month
        components.year = year
        components.day = 1
        
        let startDate = calendar.date(from: components)!
        let range = calendar.range(of: .day, in: .month, for: startDate)!
        
        return range.compactMap { day -> Date? in
            var dayComponents = components
            dayComponents.day = day
            return calendar.date(from: dayComponents)
        }
    }
}

#Preview {
    CalculateView()
}
