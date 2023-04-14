//
//  SecondView.swift
//  ExampleXibSubclass
//
//  Created by dongyeongkang on 2023/04/14.
//

import UIKit

class SecondView: BaseView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        myLabel.text = "secondview2"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
