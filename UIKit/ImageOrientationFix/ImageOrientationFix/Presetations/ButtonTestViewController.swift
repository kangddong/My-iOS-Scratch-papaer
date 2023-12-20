//
//  ButtonTestViewController.swift
//  colltest
//
//  Created by dongyeongkang on 2022/08/01.
//

import UIKit

class ButtonTestViewController: UIViewController {
    var window: UIWindow?
    
    @IBOutlet weak var testImageview: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.window?.rootViewController = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    @IBAction func rotateImage(_ sender: UIButton) {
        testImageview.image = testImageview.image?.rotate(degrees: 90)
    }
}
