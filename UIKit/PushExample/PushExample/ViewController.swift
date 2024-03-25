//
//  ViewController.swift
//  PushExample
//
//  Created by dongyeongkang on 2023/03/10.
//

import UIKit

extension UNAuthorizationStatus: CustomStringConvertible {
    public var description: String {
        switch self {
        case .notDetermined: "notDetermined"
        case .denied: "denied"
        case .authorized: "authorized"
        case .provisional: "provisional"
        case .ephemeral: "ephemeral"
        }
    }
}
class ViewController: UIViewController {

    @IBOutlet weak var immediatelyPushButton: UIButton!
    @IBOutlet weak var authorizationStatusLabel: UILabel!
    @IBOutlet weak var requestAuthorizationButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        immediatelyPushButton.addTarget(self, action: #selector(push), for: .touchUpInside)
        requestAuthorizationButton.addTarget(self, action: #selector(push2), for: .touchUpInside)
        requestAutorization()
    }
    
    private func requestAutorization() {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getNotificationSettings { setting in
            print(setting.authorizationStatus)
            DispatchQueue.main.async {
                self.authorizationStatusLabel.text = "Push Authorization: " + setting.authorizationStatus.description
                self.authorizationStatusLabel.sizeToFit()
            }
        }
    }
    @objc
    private func push() {
        print(#function)
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = "PushExample"
        content.body = "Every Tuesday at 2pm, Every Tuesday at 2pm"
        
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current

        dateComponents.weekday = 3  // Tuesday
        dateComponents.hour = 14    // 14:00 hours
           
        // Create the trigger as a repeating event.
        let trigger = UNCalendarNotificationTrigger(
                 dateMatching: dateComponents, repeats: true)
        let immediatelyTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
        let request = UNNotificationRequest(identifier: "identifier", content: content, trigger: immediatelyTrigger)
        center.add(request)
    }

    @objc
    private func push2() {
        requestAutorization()
    }
}

