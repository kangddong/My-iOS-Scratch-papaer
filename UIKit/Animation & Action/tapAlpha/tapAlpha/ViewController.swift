//
//  ViewController.swift
//  tapAlpha
//
//  Created by dongyeongkang on 2022/12/29.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var alphaHeaderView: UIView!
    @IBOutlet weak var backgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(blinkHeaderView))
        
        let tap2: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(testTap))
        
        alphaHeaderView.addGestureRecognizer(tap2)
        backgroundView.addGestureRecognizer(tap)
    }

    @objc
    func testTap() {
        print("exist View")
    }
        
    @objc
    func blinkHeaderView() {
        print("blinkHeaderView")
        
//        if alphaHeaderView.alpha == 0 {
//            UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseIn], animations: {
//                self.alphaHeaderView.alpha = 0.5
//                //self.alphaHeaderView.isHidden = false
//            })
//
//        } else {
//            UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseIn], animations: {
//                self.alphaHeaderView.alpha = 0.0
//                //self.alphaHeaderView.isHidden = false
//            })
//        }
        
        if alphaHeaderView.isHidden {
            //alphaHeaderView.isHidden = false
            
            UIView.animate(withDuration: 0.3,
                           delay: 0,
                           options: [.curveEaseIn],
                           animations: {
                self.alphaHeaderView.alpha = 0.5
            })
            
        } else {
            
            UIView.animate(withDuration: 0.3,
                           delay: 0,
                           options: [.curveEaseIn],
                           animations: {
                self.alphaHeaderView.alpha = 0.0
            },
                           completion: { _ in
                //self.alphaHeaderView.isHidden.toggle()
            })
        }
    }

}

