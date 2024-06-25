//
//  ExVisionOSVolumeApp.swift
//  ExVisionOSVolume
//
//  Created by 강동영 on 6/25/24.
//

import SwiftUI

@main
struct ExVisionOSVolumeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .windowStyle(.volumetric)
    }
}
