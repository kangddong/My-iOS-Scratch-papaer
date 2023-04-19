//
//  ViewController.swift
//  PracticeSnapKit
//
//  Created by dongyeongkang on 2022/10/12.
//
// make -> update crashLayout -> Crash
// make -> update Layout -> Pass
// make -> remake Layout -> update crashLayout -> Pass

import UIKit
import SnapKit

class ViewController: UIViewController {

    lazy var box = UIView()
    
    lazy var remakeButton: UIButton = {
        let button: UIButton = UIButton()
        button.backgroundColor = .systemOrange
        button.setTitle("remake Layout", for: .normal)
        button.addTarget(self, action: #selector(remakeLayoutButton), for: .touchUpInside)
        return button
    }()
    
    lazy var crashButton: UIButton = {
        let button: UIButton = UIButton()
        button.backgroundColor = .systemOrange
        button.setTitle("update crashLayout", for: .normal)
        button.addTarget(self, action: #selector(crashLayoutButton), for: .touchUpInside)
        return button
    }()
    
    lazy var updateButton: UIButton = {
        let button: UIButton = UIButton()
        button.backgroundColor = .systemOrange
        button.setTitle("update Layout", for: .normal)
        button.addTarget(self, action: #selector(updateLayoutButton), for: .touchUpInside)
        return button
    }()
    
    @objc
    func remakeLayoutButton() {
        box.snp.remakeConstraints { make -> Void in
            make.top.equalTo(view).inset(100)
            make.centerX.equalTo(view).inset(100)
            make.size.equalTo(200)
        }
    }
    
    // make에 없는 제약 조건을 업데이트해서 Crash 나는 Case
    // Fatal Error: Updated constraint could not find existing matching constraint to update:
    @objc
    func crashLayoutButton() {
        box.snp.updateConstraints { make -> Void in
            make.top.equalTo(view).inset(20)
        }
    }
    
    @objc
    func updateLayoutButton() {
        box.snp.updateConstraints { make -> Void in
            make.size.equalTo(100)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(box)
        self.view.addSubview(remakeButton)
        self.view.addSubview(crashButton)
        self.view.addSubview(updateButton)
        
        box.backgroundColor = .green
        box.snp.makeConstraints { make -> Void in
            make.center.equalTo(view)
            make.size.equalTo(200)
        }
        
        remakeButton.snp.makeConstraints { make -> Void in
            make.leading.trailing.equalTo(updateButton)
            make.bottom.equalTo(crashButton.snp.top).inset(-10)
            make.height.equalTo(80)
        }
        
        crashButton.snp.makeConstraints { make -> Void in
            make.leading.trailing.equalTo(updateButton)
            make.bottom.equalTo(updateButton.snp.top).inset(-10)
            make.height.equalTo(80)
        }
        
        updateButton.snp.makeConstraints { make -> Void in
            make.leading.trailing.equalTo(view).inset(30)
            make.bottom.equalTo(view).inset(50)
            make.height.equalTo(80)
        }
    }


}

