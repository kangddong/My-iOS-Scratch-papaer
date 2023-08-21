//
//  ViewController.swift
//  AwakeAppScheme
//
//  Created by dongyeongkang on 2023/08/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func awakeApp(_ sender: UIButton) {
        
        let schemeURL = "your-app://"
        if let url = URL(string: schemeURL) {
            print("URL init success !!")
            if UIApplication.shared.canOpenURL(url) {
                print("open success !!")
                UIApplication.shared.open(url)
            } else {
                print("open fail !!")
            }
        } else {
            print("URL init fail !!")
        }
        
    }
    
}

