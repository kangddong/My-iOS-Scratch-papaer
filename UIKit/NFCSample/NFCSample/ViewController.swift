//
//  ViewController.swift
//  NFCSample
//
//  Created by 강동영 on 2023/03/28.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        _setNavi()
    }
    
    private func _setNavi() {
        title = "NFC Card List"
        navigationItem.setRightBarButton(
            UIBarButtonItem(
                title: "Regist",
                style: .plain,
                target: self,
                action: #selector(_goRegist)),
            animated: true)
    }

    @objc
    private func _goRegist() {
        print(#function)
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: NFCRegistViewController.identifier) else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

