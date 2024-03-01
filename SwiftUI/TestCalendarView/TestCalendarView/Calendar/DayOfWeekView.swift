//
//  DayOfWeekView.swift
//  TestCalendarView
//
//  Created by 강동영 on 3/1/24.
//

import SwiftUI

struct DayOfWeekView: View {
    private let days: [DayOfWeek] = DayOfWeek.allCases
    var body: some View {
        HStack {
            ForEach(days, id: \.text) { day in
                Text(day.text)
                    .font(.system(size: 16))
                    .frame(maxWidth: .infinity)
                    .foregroundStyle({ () -> Color in
                        switch day {
                        case .sunday: .red
                        case .saturday: .accentColor
                        default: Color(.label)
                        }
                    }())
            }
        }
    }
}

fileprivate enum DayOfWeek: CaseIterable {
    case sunday, monday, tuesday, wednesday, thursday, friday, saturday
    
    var text: String {
        switch self {
        case .sunday: "일"
        case .monday: "월"
        case .tuesday: "화"
        case .wednesday: "수"
        case .thursday: "목"
        case .friday: "금"
        case .saturday: "토"
        }
    }
}
#Preview {
    DayOfWeekView()
}
