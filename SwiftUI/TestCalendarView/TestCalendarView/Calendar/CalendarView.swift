//
//  CalendarView.swift
//  TestCalendarView
//
//  Created by 강동영 on 3/2/24.
//

import SwiftUI

struct CalendarView: View {
    @Binding var isFullScreen: Bool
    @Binding var selectedDay: String
    @Binding var scrollOffset: CGFloat
    
    let yearAndMonth: Date = Date()
    
    var body: some View {
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

#Preview {
    CalendarView(
        isFullScreen: .constant(false),
        selectedDay: .constant("1"),
        scrollOffset: .constant(0.0))
}
