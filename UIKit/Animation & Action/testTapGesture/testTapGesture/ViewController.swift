//
//  ViewController.swift
//  testTapGesture
//
//  Created by dongyeongkang on 2022/12/27.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var testView: UIView!
    @IBOutlet weak var otpView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let doubleTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(testDoubleTapAction(_:)))
        doubleTap.numberOfTapsRequired = 2
        //let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(testTapAction))
        
        testView.addGestureRecognizer(doubleTap)
        otpView.addGestureRecognizer(doubleTap)
    }


    @objc
    func testTapAction() {
        print("Tap Action Method Called by View")
    }
    
    @objc
    func testDoubleTapAction(_ recognizer: UITapGestureRecognizer) {
        print("Tap Action Method Called by View")
        switch recognizer.state {
            
        case .possible:
            print("possible")
        case .began:
            print("began")
        case .changed:
            print("changed")
        case .ended:
            print("ended")
        case .cancelled:
            print("cancelled")
        case .failed:
            print("failed")
        @unknown default:
            print("default")
        }
        
        if otpView.zoomScale == CGFloat(1) {
            otpView.setZoomScale(3, animated: true)
        } else {
            otpView.setZoomScale(1, animated: true)
        }
    }
}

