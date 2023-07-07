//
//  LeftTabViewController.swift
//  refactoringCustomTabView
//
//  Created by dongyeongkang on 2023/07/07.
//

import UIKit

class LeftTabViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        
        let label = UILabel()
        label.text = "Left Tab"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 30)
        
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}
