//
//  ExControlLiveActivity.swift
//  ExControl
//
//  Created by 강동영 on 6/13/24.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct ExControlAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct ExControlLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: ExControlAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension ExControlAttributes {
    fileprivate static var preview: ExControlAttributes {
        ExControlAttributes(name: "World")
    }
}

extension ExControlAttributes.ContentState {
    fileprivate static var smiley: ExControlAttributes.ContentState {
        ExControlAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: ExControlAttributes.ContentState {
         ExControlAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: ExControlAttributes.preview) {
   ExControlLiveActivity()
} contentStates: {
    ExControlAttributes.ContentState.smiley
    ExControlAttributes.ContentState.starEyes
}
