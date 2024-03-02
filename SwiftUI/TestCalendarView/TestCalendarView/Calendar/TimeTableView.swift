//
//  TimeTableView.swift
//  TestCalendarView
//
//  Created by 강동영 on 3/1/24.
//

import SwiftUI

struct TimeTableView<C: View>: View {
    
    let content: () -> C
    
    @State private var isFullScreen: Bool = false
    @State private var selectedDay: String = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: Date())
    }()
    @State private var scrollOffset: CGFloat = 0.0
    
    let yearAndMonth: Date = Date()
    
    init(@ViewBuilder content: @escaping () -> C) {
        self.content = content
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
            CalendarView(
                isFullScreen: $isFullScreen,
                selectedDay: $selectedDay,
                scrollOffset: $scrollOffset)
        }
    }
}

#Preview {
    TimeTableView {
        Text("Hello, world!")
    }
}
