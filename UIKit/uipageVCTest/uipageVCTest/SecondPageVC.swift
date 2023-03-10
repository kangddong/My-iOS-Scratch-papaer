//
//  SecondPageVC.swift
//  uipageVCTest
//
//  Created by dongyeongkang on 2022/09/07.
//

import UIKit

class SecondPageVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let label = UILabel(frame: CGRect(x: view.frame.maxX / 2, y: 200, width: 100, height: 100))
        label.text = "2"
        label.font = UIFont.boldSystemFont(ofSize: 60)
        view.addSubview(label)
        view.layer.backgroundColor = UIColor.blue.cgColor
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
