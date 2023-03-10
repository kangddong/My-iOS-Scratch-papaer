//
//  ViewController.swift
//  exerciseTooltipView
//
//  Created by dongyeongkang on 2023/02/07.
//

import UIKit

class ViewController: UIViewController {
    

    private let width = 177.0
    private let height = 56.0
      
    private lazy var myView = TooltipView(
      viewColor: UIColor.systemOrange,
      tipStartX: 70.5,
      tipWidth: 11.0,
      tipHeight: 6.0
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myView.translatesAutoresizingMaskIntoConstraints = false
        myView.addLabel(text: "iOS 앱 개발 알아가기, jake블로그, tipView 포스팅 글")
        self.view.addSubview(myView)

        
        
        NSLayoutConstraint.activate([
            myView.widthAnchor.constraint(equalToConstant: self.width),
            myView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            myView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
        ])
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        
//        NSLayoutConstraint.activate([
//            myView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
//            myView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
//            myView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
//        ])
//    }


}

