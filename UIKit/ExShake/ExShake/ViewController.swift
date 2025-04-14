//
//  ViewController.swift
//  ExShake
//
//  Created by 강동영 on 4/14/25.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        switch motion {
        case .none:
            print("none")
        case .motionShake:
            print("motionShake")
        case .remoteControlPlay:
            print("remoteControlPlay")
        case .remoteControlPause:
            print("remoteControlPause")
        case .remoteControlStop:
            print("remoteControlStop")
        case .remoteControlTogglePlayPause:
            print("remoteControlTogglePlayPause")
        case .remoteControlNextTrack:
            print("remoteControlNextTrack")
        case .remoteControlPreviousTrack:
            print("remoteControlPreviousTrack")
        case .remoteControlBeginSeekingBackward:
            print("remoteControlBeginSeekingBackward")
        case .remoteControlEndSeekingBackward:
            print("remoteControlEndSeekingBackward")
        case .remoteControlBeginSeekingForward:
            print("remoteControlBeginSeekingForward")
        case .remoteControlEndSeekingForward:
            print("remoteControlEndSeekingForward")
        }
    }

}

