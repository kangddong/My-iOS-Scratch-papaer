//
//  ViewController.swift
//  AutoLayout
//
//  Created by dongyeongkang on 2022/07/07.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var thirdView: UIView!
    
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var thirdLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initLayout()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        initLayout()
        print(thirdView.frame.width.description)
    }
    
    func initLayout() {
        firstLabel.text = firstView.frame.width.description
        secondLabel.text = secondView.frame.width.description
        thirdLabel.text = thirdView.frame.width.description
            
    }

}
