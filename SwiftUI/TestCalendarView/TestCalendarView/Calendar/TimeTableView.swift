//
//  TimeTableView.swift
//  TestCalendarView
//
//  Created by 강동영 on 3/1/24.
//

import SwiftUI

struct TimeTableView<C: View>: View {
    
    let content: () -> C
    
    @State var isFullScreen: Bool = false
    @State var selectedDay: String = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: Date())
    }()
    @State var scrollOffset: CGFloat = 0.0
    
    let yearAndMonth: Date = Date()
    
    init(@ViewBuilder content: @escaping () -> C) {
        self.content = content
    }
    
    func getTodayToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        return dateFormatter.string(from: Date())
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
    
    var body: some View {
        ZStack(alignment: .top) {
            GeometryReader { outsideProxy in
                ScrollView(showsIndicators: false) {
                    GeometryReader { insideProxy in
                        Color(.systemBackground)
                            .frame(height: 16)
                            .onChange(of: insideProxy.frame(in: .global).minY) { newValue in
                                scrollOffset = outsideProxy.frame(in: .global).minY - newValue
                            }
                    }
                    content()
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                        .padding(.top, 280)
                        .padding(.bottom, 16)
                        // 최소 크기 없애려면 이 밑에 한줄 지우시면 됩니다.
                        .frame(minHeight: outsideProxy.size.height + 280, alignment: .top)
                }
                .transition(.move(edge: .bottom).combined(with: .opacity))
                .onAppear {
                    scrollOffset = 0.0
                }
            }
            VStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 15) {
                    Text({ () -> String in
                        let formatter = DateFormatter()
                        formatter.dateFormat = "yyyy년 M월"
                        return formatter.string(from: yearAndMonth)
                    }())
                    .font(.system(size: 24))
                    DayOfWeekView()
                    DaysOfCalendarView(
                        isFullScreen: $isFullScreen,
                        selectedDay: $selectedDay,
                        scrollOffset: $scrollOffset)
                }
                .padding([.horizontal, .bottom], 16)
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(maxWidth: .infinity)
                    .frame(height: 1)
            }
            .background(Color(.systemBackground))
        }
    }
}

#Preview {
    TimeTableView {
        Text("Hello, world!")
    }
}
