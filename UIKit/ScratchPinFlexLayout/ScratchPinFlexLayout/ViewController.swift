//
//  ViewController.swift
//  ScratchPinFlexLayout
//
//  Created by 강동영 on 2023/06/21.
//

import UIKit

class ViewController: BaseViewController {
    fileprivate var mainView: IntroView {
        return self.view as! IntroView
    }

    override init() {
        super.init()
        title = "FlexLayout Examples"
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = IntroView()
    }

}

class BaseViewController: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
