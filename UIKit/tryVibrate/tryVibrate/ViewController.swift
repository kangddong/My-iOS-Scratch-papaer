//
//  ViewController.swift
//  tryVibrate
//
//  Created by dongyeongkang on 2023/01/18.
//

import UIKit
import AVFoundation
import CoreHaptics

class ViewController: UIViewController {

    @IBOutlet weak var imgvAvatar: UIView!
    
    var engine: CHHapticEngine?
    var pulseLayers = [CAShapeLayer]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgvAvatar.layer.cornerRadius = imgvAvatar.frame.size.width/2.0
        
//        createPulse() {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
//                self.imgvAvatar.isHidden = true
//            })
//        }
        
//        addLongPressGesture()
        
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch let error {
            fatalError("Engine Creation Error: \(error)")
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        UIDevice.vibrate()
//        feedback()
        print("touchesBegan")
        //startHapticsPlayer()
    }
    
    func createPulse(complete: @escaping ()->()) {
        
        for _ in 0...2 {
            let circularPath = UIBezierPath(arcCenter: .zero, radius: UIScreen.main.bounds.size.width/2.0, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
            let pulseLayer = CAShapeLayer()
            pulseLayer.path = circularPath.cgPath
            pulseLayer.lineWidth = 2.0
            pulseLayer.fillColor = UIColor.clear.cgColor
            pulseLayer.lineCap =  CAShapeLayerLineCap.round
            pulseLayer.position = CGPoint(x: imgvAvatar.frame.size.width/2.0, y: imgvAvatar.frame.size.width/2.0)
            imgvAvatar.layer.addSublayer(pulseLayer)
            pulseLayers.append(pulseLayer)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.animatePulse(index: 0)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                self.animatePulse(index: 1)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.animatePulse(index: 2)
                    complete()
                }
            }
        }
    }
    
    func animatePulse(index: Int) {
        pulseLayers[index].strokeColor = UIColor.white.cgColor

        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.duration = 2.0
        scaleAnimation.fromValue = 0.0
        scaleAnimation.toValue = 0.9
        scaleAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        scaleAnimation.repeatCount = .greatestFiniteMagnitude
        pulseLayers[index].add(scaleAnimation, forKey: "scale")
        
        let opacityAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
        opacityAnimation.duration = 2.0
        opacityAnimation.fromValue = 0.9
        opacityAnimation.toValue = 0.0
        opacityAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        opacityAnimation.repeatCount = .greatestFiniteMagnitude
        pulseLayers[index].add(opacityAnimation, forKey: "opacity")
    }
    
    private func addLongPressGesture() {
        
        let longPress: UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPress(_ :)))
        //longPress.numberOfTapsRequired = 0
        //longPress.numberOfTouchesRequired = 1
        //longPress.minimumPressDuration = 0.0
        longPress.allowableMovement = 1
        view.addGestureRecognizer(longPress)
    }
    
    private func startHapticsPlayer() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }

        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.1)
        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)

        do {
            let pattern = try CHHapticPattern(events: [event], parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription).")
        }
    }
    
    @objc
    func longPress(_ sender: UIGestureRecognizer) {
        print("longpress")
        print(".location(in: view = \(sender.location(in: view))")
        UIDevice.vibrate()
    }
    
    @objc
    private func feedback() {
        HapticManager.shared.vibrate(for: .error)
    }

}

extension UIDevice {
    
    // 단발성 진동 발생
    static func vibrate() {
        print(#function)
        DispatchQueue.main.async {
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
            //AudioServicesPlaySystemSound(1520) // UInt32
        }
    }
}
