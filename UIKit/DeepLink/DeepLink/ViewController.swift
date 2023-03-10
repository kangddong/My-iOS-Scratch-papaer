//
//  ViewController.swift
//  DeepLink
//
//  Created by dongyeongkang on 2022/06/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 9, left: 9, bottom: 9, right: 0.2)
    }


    @IBAction func goContact(_ sender: UIButton) {
        openAppPreference()
    }
    
    func openAppPreference() {
        guard let nsUrl = UIApplication.openSettingsURLString.toURL() else { return }
        //let url = nsUrl as URL
        //let url = URL(string: "https://tom7930.tistory.com/54")!
        //let url = URL(string: "tel:01044010641")!
        let url = URL(string: "mobilephone:")!
                
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
   }
}

extension String {
    var length: Int { return self.count }
    
    func toURL() -> NSURL? {
        return NSURL(string: self)
    }
}
