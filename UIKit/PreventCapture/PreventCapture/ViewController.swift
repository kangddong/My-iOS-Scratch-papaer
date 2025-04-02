//
//  ViewController.swift
//  PreventCapture
//
//  Created by 강동영 on 3/28/25.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    private let imageView: UIImageView = .init(image: UIImage(systemName: "rectangle.portrait.and.arrow.forward.fill"))
    private let swiftUIView = SampleView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let hostingController = UIHostingController(rootView: swiftUIView)
        addChild(hostingController)
        hostingController.view.frame = view.frame
//        hostingController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(hostingController.view)
        hostingController.view.makeSecure()
        hostingController.didMove(toParent: self)
        
//        imageView.makeSecure()
//        
//        view.addSubview(imageView)
//        
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//            imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//            imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
//        ])
    }


}

extension UIView {
    func makeSecure() {
        DispatchQueue.main.async {
            let textfield = UITextField()
            textfield.isSecureTextEntry = true
            
            self.addSubview(textfield)
            textfield.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            textfield.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            
            textfield.layer.removeFromSuperlayer()
//            self.layer.superlayer?.addSublayer(textfield.layer)
            self.layer.superlayer?.insertSublayer(textfield.layer, at: 0)
            textfield.layer.sublayers?.last?.addSublayer(self.layer)
        }
    }
}
