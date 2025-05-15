//
//  ContentView.swift
//  ActivityKitPractice
//
//  Created by dongyeongkang on 2022/11/25.
//

import SwiftUI
import ActivityKit

struct ContentView: View {
    var body: some View {
        VStack {
            Button("Start") {
                
                let now = Date()
                let future = now.addingTimeInterval(3600)
                let timer = now...future
                // TODO
                let dynamicIslandWidgetAttributes =
                DynamicIslandPracticeAttributes(user1: "동영", totalAmount: "10", orderNumber: "200")
                let contentState = DynamicIslandPracticeAttributes.ContentState(centerPoint: "강남", user2: "여자친구 1", deliveryTimer: timer)
                
                      
                do {
                  let activity = try Activity<DynamicIslandPracticeAttributes>.request(
                  attributes: dynamicIslandWidgetAttributes,
                  contentState: contentState
                )
                print(activity)
                } catch {
                print(error)
                }
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
