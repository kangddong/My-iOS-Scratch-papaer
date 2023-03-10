//
//  ViewController2.swift
//  tryVibrate
//
//  Created by dongyeongkang on 2023/01/18.
//

import UIKit
import CoreHaptics

class ViewController2: UIViewController {

    var engine: CHHapticEngine?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        do {
            engine = try CHHapticEngine()
        } catch let error {
            fatalError("Engine Creation Error: \(error)")
        }
    }
    
    @objc
    func startEngine() {
        engine?.resetHandler = {
            
            print("Reset Handler: Restarting the engine")
            
            do {
                
                try self.engine?.start()
            } catch {
                fatalError("Failed to restart the engine: \(error)")
            }
        }
    }
    
    @objc
    func stoppedEngine() {
        engine?.stoppedHandler = { reason in
            
            print("Stop Handler: The engine stopped for reason: \(reason.rawValue)")
            switch reason {
            case .audioSessionInterrupt: print("Audio session interrupt")
            case .applicationSuspended: print("Application suspended")
            case .idleTimeout: print("Idle timeout")
            case .systemError: print("System error")
            @unknown default:
                print("Unknown error")
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
