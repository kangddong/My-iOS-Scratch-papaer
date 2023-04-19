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
    static let youtube = Self("youtube")
}

class ViewController: UIViewController {

    lazy var showPickerButton: UIButton = {
        let button: UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemOrange
        button.setTitle("show", for: .normal)
        button.addTarget(self, action: #selector(openSwiftUIView), for: .touchUpInside)
        
        return button
    }()
    
    lazy var startMonitorButton: UIButton = {
        let button: UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemOrange
        button.setTitle("startMonitorButton", for: .normal)
        button.addTarget(self, action: #selector(startMonitor), for: .touchUpInside)
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(showPickerButton)
        view.addSubview(startMonitorButton)
        NSLayoutConstraint.activate([
            showPickerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            showPickerButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            showPickerButton.widthAnchor.constraint(equalToConstant: 100),
            showPickerButton.heightAnchor.constraint(equalToConstant: 70),
            
            startMonitorButton.topAnchor.constraint(equalTo: showPickerButton.bottomAnchor, constant: 20),
            startMonitorButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            showPickerButton.widthAnchor.constraint(equalToConstant: 100),
            showPickerButton.heightAnchor.constraint(equalToConstant: 70),
            
        ])
        
        
        
    }
    @objc
    func startMonitor() {
        print(#function)
        // 모니터링 하는 시간  범위₩₩₩₩₩₩
        let schedule = DeviceActivitySchedule(
            intervalStart: DateComponents(hour: 0, minute: 0),
            intervalEnd: DateComponents(hour: 23, minute: 59),
            repeats: true
        )
        let center = DeviceActivityCenter()
        do {
            try center.startMonitoring(.youtube, during: schedule)
        } catch let error {
            print(error.localizedDescription)
        }
        
        let events = center.events(for: .youtube)
        let schedule2 = center.schedule(for: .youtube)
        let activities = center.activities
        
        print(events)
        print(schedule2)
        print(activities)
        
        
    }
    
    static public func requestAuthorization() {
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
    
    @objc
    private func openSwiftUIView() {
        let hostingController = UIHostingController(rootView: ExampleView())
        
        hostingController.sizingOptions = .preferredContentSize
        hostingController.modalPresentationStyle = .popover
        self.present(hostingController, animated: true)
    }
}
