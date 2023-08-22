//
//  TestViewController.swift
//  testPushCrash
//
//  Created by dongyeongkang on 2023/08/22.
//

import UIKit

class TestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("======Start=======")
        print("\n")
        print(#function)
        
        let address = Unmanaged.passUnretained(self).toOpaque()
        print("address: \(address)")
        print("TestViewController: \(navigationController?.viewControllers)")
        
        
        print("\n")
        print("======End=======")
        print("\n")
    }
    

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("\n")
        print("======Start=======")
        print("\n")
        print(#function)
        
        let address = Unmanaged.passUnretained(self).toOpaque()
        print("address: \(address)")
        print("TestViewController: \(navigationController?.viewControllers)")
        
        print("\n")
        print("======End=======")
        print("\n")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("\n")
        print("======Start=======")
        print("\n")
        print(#function)
        
        let address = Unmanaged.passUnretained(self).toOpaque()
        print("address: \(address)")
        print("TestViewController: \(navigationController?.viewControllers)")
        
        print("\n")
        print("======End=======")
        print("\n")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
