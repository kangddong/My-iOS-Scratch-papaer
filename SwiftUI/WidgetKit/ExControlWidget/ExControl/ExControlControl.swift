//
//  ExControlControl.swift
//  ExControl
//
//  Created by 강동영 on 6/13/24.
//

import AppIntents
import SwiftUI
import WidgetKit

struct ExControlControl: ControlWidget {
    static let kind: String = "com.arex.ExControlWidget.ExControl"

    var body: some ControlWidgetConfiguration {
        AppIntentControlConfiguration(
            kind: Self.kind,
            provider: Provider()
        ) { value in
            ControlWidgetToggle(
                "Start Timer",
                isOn: value.isRunning,
                action: StartTimerIntent(value.name),
                valueLabel: { isRunning in
                    Label(isRunning ? "On" : "Off", systemImage: "timer")
                }
            )
        }
        .displayName("Timer")
        .description("A an example control that runs a timer.")
    }
}

extension ExControlControl {
    struct Value {
        var isRunning: Bool
        var name: String
    }

    struct Provider: AppIntentControlValueProvider {
        func previewValue(configuration: TimerConfiguration) -> Value {
            ExControlControl.Value(isRunning: false, name: configuration.timerName)
        }

        func currentValue(configuration: TimerConfiguration) async throws -> Value {
            let isRunning = true // Check if the timer is running
            return ExControlControl.Value(isRunning: isRunning, name: configuration.timerName)
        }
    }
}

struct TimerConfiguration: ControlConfigurationIntent {
    static var title: LocalizedStringResource { "Timer Name Configuration" }

    @Parameter(title: "Timer Name")
    var timerName: String
}

struct StartTimerIntent: SetValueIntent {
    static var title: LocalizedStringResource { "Start a timer" }

    @Parameter(title: "Timer Name")
    var name: String

    @Parameter(title: "Timer is running")
    var value: Bool

    init() {}

    init(_ name: String) {
        self.name = name
    }

    func perform() async throws -> some IntentResult {
        // Start the timer…
        return .result()
    }
}
