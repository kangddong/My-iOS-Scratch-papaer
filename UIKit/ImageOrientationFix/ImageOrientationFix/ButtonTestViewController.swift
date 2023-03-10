//
//  ButtonTestViewController.swift
//  colltest
//
//  Created by dongyeongkang on 2022/08/01.
//

import UIKit

class ButtonTestViewController: UIViewController {
    var window: UIWindow?
    
    @IBOutlet weak var testview: UIView!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.window?.rootViewController = self
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(changeCategoryAction(_:)))
        
        testview.addGestureRecognizer(tapRecognizer)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
  
    @objc func changeCategoryAction(_ recognizer: UITapGestureRecognizer) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc2 = sb.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        let ad = UIApplication.shared.delegate as! AppDelegate
        ad.window?.rootViewController = vc2
        //AppDelegate.ad?.logout()
        label.text = "recognizer.state"
    }
}

extension ButtonTestViewController {
    func aasdasds() {
        let tapRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(changeCategoryAction2(_:)))
            
            let doubleTap = UITapGestureRecognizer(target: self, action: #selector(changeCategoryAction3(_:)))
            doubleTap.numberOfTapsRequired = 2
        
        testview.addGestureRecognizer(tapRecognizer2)
        //testview.addGestureRecognizer(tapRecognizer)
        testview.addGestureRecognizer(doubleTap)
        testview.isUserInteractionEnabled = true
    }
    
    
    @objc func changeCategoryAction2(_ recognizer: UITapGestureRecognizer) {
        print("recognizer.state = \(recognizer.state)")
        print("recognizer.state = \(recognizer.state.rawValue)")
        label.text = "recognizer.state222"
        print(label.text)
        
    }
    
    @objc func changeCategoryAction3(_ recognizer: UITapGestureRecognizer) {
        print("recognizer.state = \(recognizer.state)")
        print("recognizer.state = \(recognizer.state.rawValue)")
        label.text = "recognizer.state doubleTap"
        print(label.text)
    }
}
