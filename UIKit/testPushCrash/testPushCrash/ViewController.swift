//
//  ViewController.swift
//  testPushCrash
//
//  Created by dongyeongkang on 2023/08/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var testButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testButton.addTarget(self, action: #selector(crash1), for: .touchUpInside)
    }

    @objc
    func crash1() {
        print("\n")
        print("======Start=======")
        print("\n")
        print(#function)
//        navigationController?.pushViewController(TestViewController(), animated: true)
//        print("viewControllers: \(navigationController?.viewControllers)")
//        navigationController?.pushViewController(TestViewController2(), animated: true)
//        print("viewControllers: \(navigationController?.viewControllers)")
//        navigationController?.pushViewController(TestViewController3(), animated: true)
//        print("viewControllers: \(navigationController?.viewControllers)")
        
        
        let testViewController = TestViewController()
        let testViewController2 = TestViewController()
        let testViewController3 = TestViewController()
        let address = Unmanaged.passUnretained(testViewController).toOpaque()
        let address2 = Unmanaged.passUnretained(testViewController2).toOpaque()
        let address3 = Unmanaged.passUnretained(testViewController3).toOpaque()
        print("address: \(address)")
        print("address2: \(address2)")
        print("address3: \(address3)")
        
        navigationController?.pushViewController(testViewController, animated: false)
        print("viewControllers: \(navigationController?.viewControllers)")
        navigationController?.pushViewController(testViewController2, animated: true)
        print("viewControllers: \(navigationController?.viewControllers)")
        navigationController?.pushViewController(testViewController3, animated: true)
        print("viewControllers: \(navigationController?.viewControllers)")
        
        print("\n")
        print("--------End-----------")
        print("\n")
    }

}

