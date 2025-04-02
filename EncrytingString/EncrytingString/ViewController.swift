//
//  ViewController.swift
//  EncrytingString
//
//  Created by 강동영 on 3/26/25.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let idTextfield: UITextField = .init(frame: CGRect(
            x: 50, y: 200, width: 250, height: 60)
        )
        let pwTextfield: UITextField = .init(frame: CGRect(
            x: 50, y: 280, width: 250, height: 60)
        )
        idTextfield.borderStyle = .roundedRect
        pwTextfield.borderStyle = .roundedRect
        view.addSubview(idTextfield)
        view.addSubview(pwTextfield)
    }


}

