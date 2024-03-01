//
//  ContentView.swift
//  TestCalendarView
//
//  Created by 강동영 on 3/1/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            TimeTableView {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("CalendarView")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
