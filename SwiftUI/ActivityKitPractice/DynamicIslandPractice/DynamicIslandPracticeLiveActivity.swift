//
//  DynamicIslandPracticeLiveActivity.swift
//  DynamicIslandPractice
//
//  Created by dongyeongkang on 2022/11/25.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct DynamicIslandPracticeAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        //var driverName: String
        var centerPoint: String
        var user2: String
        var deliveryTimer: ClosedRange<Date>
    }

    // Fixed non-changing properties about your activity go here!
    var user1: String
    var totalAmount: String
    var orderNumber: String
}

struct DynamicIslandPracticeLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: DynamicIslandPracticeAttributes.self) { context in
            // Lock screen/banner UI goes here
            // Create the presentation that appears on the Lock Screen and as a
            // banner on the Home Screen of devices that don't support the
            // Dynamic Island.
            LockScreenLiveActivityView(context: context)
            
        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Label("\(context.attributes.user1)", systemImage: "figure.run")
                        .font(.body)
                                            
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Label {
                        Text("\(context.state.user2)")
                        } icon: {
                            Image(systemName: "figure.run")
                                .foregroundColor(.indigo)
                                .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1.0, z: 0))
                        }
                        .font(.body)
                }
                DynamicIslandExpandedRegion(.center) {
                    Text("\(context.state.centerPoint)에서 약속 !")
                        .lineLimit(1)
                        .font(.caption)
                }
                DynamicIslandExpandedRegion(.bottom) {
                    VStack {
                        Button {
                            // Deep link into your app.
                        } label: {
                            Label("", systemImage: "heart.square.fill")
                        }
                        .foregroundColor(.indigo)
                        Text(timerInterval: context.state.deliveryTimer, countsDown: true)
                            .multilineTextAlignment(.center)
                            .frame(width: 60)
                            .monospacedDigit()
                    }
                    
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T")
            } minimal: {
                Text("Min")
            }
            .contentMargins(.trailing, 8, for: .expanded)
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

struct LockScreenLiveActivityView: View {
    let context: ActivityViewContext<DynamicIslandPracticeAttributes>
    
    var body: some View {
        VStack {
            Spacer()
            Text("\(context.state.centerPoint)에서 약속 !")
            Spacer()
            HStack {
                Spacer()
                Label {
                    Text("\(context.attributes.user1)")
                } icon: {
                    Image(systemName: "figure.run")
                        .foregroundColor(.indigo)
                }
                .font(.body)
                Spacer()
                VStack {
                    Image(systemName: "heart.square.fill")
                        .renderingMode(.original)
                    Text(timerInterval: context.state.deliveryTimer, countsDown: true)
                        .multilineTextAlignment(.center)
                        .frame(width: 60)
                        .monospacedDigit()
                }
                .frame(alignment: .center)
                Label {
                    Text("\(context.state.user2)")
                } icon: {
                    Image(systemName: "figure.run")
                        .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1.0, z: 0))
                        .foregroundColor(.indigo)
                }
                .font(.body)
                Spacer()
            }
            Spacer()
        }
        .activitySystemActionForegroundColor(.cyan)
        .activityBackgroundTint(.black)
    }
}

//struct LockScreenLiveActivityView_Previews: PreviewProvider {
//    static var previews: some View {
//        ActivityConfiguration(for: DynamicIslandPracticeAttributes.self) { context in
//            LockScreenLiveActivityView(context: context)
//        } dynamicIsland: { context in
//            <#code#>
//        }
//    }
//}
