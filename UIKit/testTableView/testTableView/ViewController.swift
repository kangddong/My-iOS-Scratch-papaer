//
//  ViewController.swift
//  testTableView
//
//  Created by dongyeongkang on 2022/12/26.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print("isModal: \(isModal)")
    }


}

extension ViewController {
    var isModal: Bool {
        if let navi = self.navigationController, navi.viewControllers.first == self {
            return true
        }
        
        if self.presentingViewController != nil {
            return true
        }
        
        if self.navigationController?.presentingViewController?.presentedViewController == self.navigationController {
            return true
        }
        
        if self.tabBarController?.presentingViewController != nil {
            return true
        }
        
        return false
    }
}
