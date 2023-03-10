//
//  SignUpViewController.swift
//  uipageVCTest
//
//  Created by dongyeongkang on 2022/11/14.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var header: UIView!
    @IBOutlet weak var progress: UIProgressView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    lazy var firstVC = FirstPageVC()
    lazy var secondVC = SecondPageVC()
    lazy var thirdVC = ThirdPageVC()
    lazy var vcList = [firstVC, secondVC, thirdVC]
    lazy var currentVC: UIViewController = firstVC

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
