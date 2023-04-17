//
//  ViewController.swift
//  PushExample
//
//  Created by dongyeongkang on 2023/03/10.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var immediatelyPushButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        immediatelyPushButton.addTarget(self, action: #selector(push), for: .touchUpInside)
    }
    
    @objc
    private func push() {
        print(#function)
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = "Tublock"
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


}

