//
//  DaysOfCalendarView.swift
//  TestCalendarView
//
//  Created by 강동영 on 3/1/24.
//

import SwiftUI

struct DaysOfCalendarView: View {
    @Binding var isFullScreen: Bool
    @Binding var selectedDay: String// = {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "d"
//        return formatter.string(from: Date())
//    }()
    @Binding var scrollOffset: CGFloat
    
    let yearAndMonth: Date = Date()
    
    var body: some View {
        VStack(spacing: { () -> CGFloat in
            if isFullScreen {
                return 0
            } else {
                let temp = 16 - scrollOffset / 70 * 16
                if temp >= 16 {
                    return 16 + -scrollOffset / 10
                } else {
                    return temp < -26 ? -26 : temp
                }
            }
        }()) {
            ForEach(getArrayOfDays(), id: \.self) { week in
                let isActive = (checkIfItsThisMonth() && week.contains(selectedDay))
                HStack {
                    ForEach(week, id: \.self) { day in
                        Button(action: {
                            selectedDay = day
                        }) {
                            ZStack {
                                if day == selectedDay {
                                    Circle()
                                        .fill(Color.accentColor)
                                }
                                Text(day)
                                    .font(.system(size: 16))
                                    .foregroundStyle({ () -> Color in
                                        if day == selectedDay {
                                            .white
                                        } else {
                                            switch day {
                                            case week.first: .red
                                            case week.last: .accentColor
                                            default: Color(.label)
                                            }
                                        }
                                    }())
                                if day == getTodayToString() {
                                    Circle()
                                        .strokeBorder(Color.accentColor, lineWidth: 2)
                                }
                            }
                        }
                        .frame(width: 26, height: 26)
                        .frame(maxWidth: .infinity)
                    }
                }
                .zIndex(isActive ? 1 : 0)
                .opacity({ () -> CGFloat in
                    if isActive {
                        1
                    } else {
                        1 - scrollOffset / 175
                    }
                }())
                .onAppear {
                    scrollOffset = 0.0
                }
                if isFullScreen {
                    Spacer()
                }
            }
        }
    }
    
    func getArrayOfDays() -> [[String]] {
        let calendar = Calendar.current
        
        let month = calendar.component(.month, from: yearAndMonth)
        let year = calendar.component(.year, from: yearAndMonth)
        let firstDayOfMonth = calendar.date(from: DateComponents(year: year, month: month))!
        
        let daysInMonth = calendar.range(of: .day, in: .month, for: firstDayOfMonth)!.count
        let firstWeekdayOfMonth = calendar.component(.weekday, from: firstDayOfMonth)
        
        var calendarDays: [[String]] = []
        var week: [String] = Array(repeating: "", count: firstWeekdayOfMonth - 1)
        
        for day in 1...daysInMonth {
            week.append(String(day))
            if week.count == 7 {
                calendarDays.append(week)
                week = []
            }
        }
        
        if !week.isEmpty {
            calendarDays.append(week)
        }
        
        let lastArray = (Array(repeating: " ", count: 7 - (calendarDays.last?.count ?? 0)))
        calendarDays[calendarDays.index(before: calendarDays.endIndex)].append(contentsOf: lastArray)
        return calendarDays
    }
    
    func checkIfItsThisMonth() -> Bool {
        let date = Date()
        let calendar = Calendar.current
        
        let year1 = calendar.component(.year, from: date)
        let month1 = calendar.component(.month, from: date)
        
        let year2 = calendar.component(.year, from: yearAndMonth)
        let month2 = calendar.component(.month, from: yearAndMonth)
        
        return year1 == year2 && month1 == month2
    }
    
    func getTodayToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        return dateFormatter.string(from: Date())
    }
}

#Preview {
    DaysOfCalendarView(
        isFullScreen: .constant(false),
        selectedDay: .constant("1"),
        scrollOffset: .constant(0.0))
}
