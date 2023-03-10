//
//  MainViewController.swift
//  BeaconSampleApp
//
//  Created by dongyeongkang on 2023/02/27.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var mainImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        mainImageView.isUserInteractionEnabled = true
        mainImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(next(_:))))
    }

    @objc
    private func next(_ recognizer: UITapGestureRecognizer) {
        guard let navi = self.storyboard?.instantiateViewController(withIdentifier: "BLENavi") else { return }
        navi.modalPresentationStyle = .fullScreen
        present(navi, animated: true)
    }

}
