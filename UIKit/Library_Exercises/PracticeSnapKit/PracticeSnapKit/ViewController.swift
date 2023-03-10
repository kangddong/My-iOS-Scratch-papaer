//
//  ViewController.swift
//  PracticeSnapKit
//
//  Created by dongyeongkang on 2022/10/12.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    lazy var box = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(box)
        box.backgroundColor = .green
        box.snp.makeConstraints { make -> Void in
            make.edges.equalTo(self.view)
        }
    }


}

