//
//  ExTCAApp.swift
//  ExTCA
//
//  Created by 강동영 on 5/26/25.
//

import SwiftUI
import ComposableArchitecture
@main
struct ExTCAApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(store: Store(initialState: Feature.State(), reducer: {
                Feature()
            }))
        }
    }
}
