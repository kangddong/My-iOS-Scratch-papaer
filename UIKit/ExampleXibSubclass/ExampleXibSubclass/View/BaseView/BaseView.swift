//
//  BaseView.swift
//  ExampleXibSubclass
//
//  Created by dongyeongkang on 2023/04/14.
//

import UIKit

class BaseView: UIView {

    @IBOutlet var myLabel: UILabel!
        // other outlets, etc.
    @IBOutlet private var rootViewFromNib: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        Bundle(for: BaseView.self).loadNibNamed("BaseView", owner: self, options: nil)
        rootViewFromNib.frame = bounds
        rootViewFromNib.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        rootViewFromNib.translatesAutoresizingMaskIntoConstraints = false
        rootViewFromNib.backgroundColor = .blue
        addSubview(rootViewFromNib)
        
        
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rootViewFromNib.topAnchor.constraint(equalTo: topAnchor),
            rootViewFromNib.leadingAnchor.constraint(equalTo: leadingAnchor),
            rootViewFromNib.trailingAnchor.constraint(equalTo: trailingAnchor),
            rootViewFromNib.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
