//
//  ViewController.swift
//  ExampleXibSubclass
//
//  Created by dongyeongkang on 2023/04/14.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let baseView: BaseView = BaseView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        view.addSubview(baseView)
        
        let secondView: SecondView = SecondView(frame: CGRect(x: 100, y: 200, width: 100, height: 100))
        view.addSubview(secondView)
//
//        NSLayoutConstraint.activate([
//            baseView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            baseView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            baseView.widthAnchor.constraint(equalToConstant: 100),
//            baseView.heightAnchor.constraint(equalToConstant: 100),
//        ])
    }


}

