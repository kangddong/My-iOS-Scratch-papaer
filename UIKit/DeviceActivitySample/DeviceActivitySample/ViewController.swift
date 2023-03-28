//
//  ViewController.swift
//  DeviceActivitySample
//
//  Created by dongyeongkang on 2023/03/28.
//

import UIKit
import DeviceActivity
import ManagedSettings
import FamilyControls
import SwiftUI

extension DeviceActivityName {
    //
    static let daily = Self("daily")
}

extension DeviceActivityEvent.Name {
    static let encouraged = Self("encouraged")
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task(priority: .userInitiated) {
            try await AuthorizationCenter.shared.requestAuthorization(for: .individual)
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            self.openSwiftUIView()
        })
    }
    
    func requestAuthorization() {
        let authorizationStatus = AuthorizationCenter.shared.authorizationStatus
        
        switch authorizationStatus {
        case .notDetermined:
            print("notDetermined")
        case .denied:
            print("denied")
        case .approved:
            print("approved")
        @unknown default:
            fatalError()
        }
    }
    
    private func openSwiftUIView() {
        let hostingController = UIHostingController(rootView: ExampleView())
        hostingController.sizingOptions = .preferredContentSize
        hostingController.modalPresentationStyle = .popover
        self.present(hostingController, animated: true)
    }
}

//extension ViewController {
//    func schedule() {
//        let scedule = DeviceActivitySchedule(
//            intervalStart: DateComponents(hour: 0, minute: 0),
//            intervalEnd: DateComponents(hour: 23, minute: 59),
//            repeats: true)
//
//
//        let center = DeviceActivityCenter()
//        do {
//            try center.startMonitoring(.daily, during: scedule)
//        } catch {
//            print(error.localizedDescription)
//        }
//    }
//
//    func event() {
//        let scedule = DeviceActivitySchedule(
//            intervalStart: DateComponents(hour: 0, minute: 0),
//            intervalEnd: DateComponents(hour: 23, minute: 59),
//            repeats: true)
//        let minutes: Int = 30
//        let model = MyModel()
////        let event: [DeviceActivityEvent.Name: DeviceActivityEvent] = [
////            .encouraged: DeviceActivityEvent(
////                applications: model.selectionToEncourage.applicationTokens,
////                threshold: DateComponents(minute: minutes))
////        ]
//    }
//}
//
//class MyModel {
//    var selectionToEncourage: (name: String, applicationTokens: [Int]) = ("", [])
////    let dummyToken: [ApplicationToken] = [
////        Application(bundleIdentifier: "com").token!,
////        Application(bundleIdentifier: "com").token!,
////        Application(bundleIdentifier: "com").token!,
////        Application(bundleIdentifier: "com").token!,
////        Application(bundleIdentifier: "com").token!,
////        Application(bundleIdentifier: "com").token!,
////    ]
////
////    init() {
////        selectionToEncourage.applicationTokens = dummyToken
////    }
//}
