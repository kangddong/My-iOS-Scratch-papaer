//
//  SFSymbol7ViewController.swift
//  HelloXcode26
//
//  Created by 강동영 on 6/11/25.
//

import UIKit

class SFSymbol7ViewController: UIViewController {

    let checkImageView = UIImageView(image: UIImage(systemName: "checkmark"))
    override func viewDidLoad() {
        super.viewDidLoad()

        checkImageView.addSymbolEffect(.bounce)
        checkImageView.frame = .init(x: 200, y: 200, width: 100, height: 100)
        view.addSubview(checkImageView)
    }
}

#Preview {
    SFSymbol7ViewController()
}
