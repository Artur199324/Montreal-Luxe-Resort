import SwiftUI

struct BookingView: View {
    @State var img:String
    @State  var title:String
    @Environment(\.dismiss) var dismiss
    @State private var selectedStartDate: Date?
    @State private var selectedEndDate: Date?
    @State private var selectedMonth = 9
    @State private var selectedYear = 2024
    @State private var numberOfAdults = 2
    @State private var numberOfChildren = 1
    @State private var ok = true
    @State private var thenk = false
    @State private var dat = ""
    private let calendar = Calendar.current
    private let years = Array(2020...2030)
    private let months = Array(1...12)
    
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
                                        .foregroundColor(.purple)
                                }
                                
                                Spacer()
                                
                                Text("\(monthName(month: selectedMonth)) \(selectedYear)")
                                    .font(.headline)
                                    .foregroundColor(.black)
                                
                                Spacer()
                                
                                Button(action: {
                                    // Next month action
                                    changeMonth(by: 1)
                                }) {
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.purple)
                                }
                                
                                Spacer()
                                
                                Button("Clear") {
                                    selectedStartDate = nil
                                    selectedEndDate = nil
                                }
                                .foregroundColor(.purple)
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
                                Stepper(value: $numberOfAdults, in: 1...10) {
                                    Text("\(numberOfAdults)")
                                        .font(.subheadline)
                                }
                            }
                            .padding(.horizontal)
                            
                            // Children stepper
                            HStack {
                                Text("Children")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                Spacer()
                                Stepper(value: $numberOfChildren, in: 0...10) {
                                    Text("\(numberOfChildren)")
                                        .font(.subheadline)
                                }
                            }
                            .padding(.horizontal)
                            
                            // Book Now button
                            Button(action: {
                                bookNow()
                            }) {
                                Image("buynow")
                            }
                            .padding(.horizontal)
                            .padding(.top, 10)
                            
                        }
                        .padding(.vertical)
                        .background(Color(UIColor(hex: "##F0EEFF")))
                        Spacer()
                    }else{
                        VStack(spacing: 20) {
                            Image("Thank you! You have successfully booked a hotel during this period. Enjoy your vacation.").padding(.top,20)
                            HStack{
                                Image("Dates").padding(.leading,20)
                                Spacer()
                                Text(dat).padding(.trailing,20)
                            }.padding(.top,20)
                            HStack{
                                Image("Adults").padding(.leading,20)
                                Spacer()
                                Text("\(numberOfAdults)").padding(.trailing,20)
                            }.padding(.top,20)
                            HStack{
                                Image("Children").padding(.leading,20)
                                Spacer()
                                Text("\(numberOfChildren)").padding(.trailing,20)
                            }.padding(.top,20)
                            
                            HStack{
                                Button {
                                    ok.toggle()
                                } label: {
                                   Image("baccc")
                                }

                                Button(action: {
                                    thenk.toggle()
                                }, label: {
                                    Image("coo")
                                })
                            }.padding(.top,30)
                         
                            Spacer()
                        } .padding(.vertical)
                            .background(Color(UIColor(hex: "##F0EEFF")))
                        
                    }
                }
                
            }.overlay(content: {
                if thenk {
                    VStack{
                        
                        Image("Frame 70").overlay {
                            Button(action: {
                                self.dismiss()
                            }, label: {
                                Image("ok 1").padding(.top,350)
                            })
                        }
                
                        
                    }.frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.8))}
                
                
                
                
            })
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Image(img).resizable().scaledToFill())
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
        if let startDate = selectedStartDate, let endDate = selectedEndDate {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            let startString = dateFormatter.string(from: startDate)
            let endString = dateFormatter.string(from: endDate)
            dat = "Booking from \(startString) to \(endString)"
            print("Booking from \(startString) to \(endString) in \(monthName(month: selectedMonth)) \(selectedYear)")
            ok.toggle()
        } else {
            print("Please select a start and end date.")
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
            return Color.blue.opacity(0.2)
        } else {
            return Color.clear
        }
    }
    
    private func foregroundColor(for date: Date) -> Color {
        return isDateInPast(date) ? Color.gray : (isSelectedDate(date) ? Color.white : Color.black)
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
