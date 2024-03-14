//
//  ViewController.swift
//  tapAlpha
//
//  Created by dongyeongkang on 2022/12/29.
//

import UIKit

final class ViewController: UIViewController {
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var alphaHeaderView: UIView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var alphaTestButton: UIButton!
    @IBOutlet weak var isHiddenTestButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var stackViewHeightLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("stackView height: \(stackView.frame.height)")
        addButtonActions()
        addTapgestures()
        result()
        print("stackView.accessibilityIdentifier: \(stackView.accessibilityIdentifier)")
        print("stackView.accessibilityIdentifier: \(stackView.tag)")
    }

    private func result() {
        let text = alphaHeaderView.isHidden ? "No" : "Yes"
        let resultText = "Is here test view ? -> \(text)"
        
        DispatchQueue.main.async {
            self.resultLabel.text = resultText
        }
        
        setStackViewHeight()
    }
    
    private func setStackViewHeight() {
        let resultText = "Pink Stackview's height ? : \(stackView.frame.height.description)"
        
        DispatchQueue.main.async {
            self.stackViewHeightLabel.text = resultText
        }
    }
    
    private func addButtonActions() {
        alphaTestButton.addTarget(self, action: #selector(testAlphaToHeaderView), for: .touchUpInside)
        isHiddenTestButton.addTarget(self, action: #selector(testIsHiddenToHeaderView), for: .touchUpInside)
    }
    
    private func addTapgestures() {
        let alphaViewTapgesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(testisExistAlphaView))
        
        alphaHeaderView.addGestureRecognizer(alphaViewTapgesture)
    }
    
    @objc
    private func testisExistAlphaView() {
        print("exist View")
        self.view.endEditing(true)
    }
        
    @objc
    private func testAlphaToHeaderView() {
        print("blinkHeaderView")
        
        if alphaHeaderView.alpha == 1.0 {
            UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseIn], animations: {
                self.alphaHeaderView.alpha = 0.0
            })
            
            DispatchQueue.main.async {
                self.alphaTestButton.setTitle(
                    "Test alpha 0.0 -> 1.0",
                    for: .normal)
            }
        } else {
            UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseIn], animations: {
                self.alphaHeaderView.alpha = 1.0
            })
            
            DispatchQueue.main.async {
                self.alphaTestButton.setTitle(
                    "Test alpha 1.0 -> 0.0",
                    for: .normal)
            }
        }
    }

    @objc
    private func testIsHiddenToHeaderView() {
        if alphaHeaderView.isHidden {
            alphaHeaderView.isHidden = false
            
            UIView.animate(withDuration: 0.3,
                           delay: 0,
                           options: [],
                           animations: {
                self.stackView.layoutIfNeeded()
            })
            
            DispatchQueue.main.async {
                self.isHiddenTestButton.setTitle(
                    "Test isHidden true -> false",
                    for: .normal)
                self.result()
            }
        } else {
            alphaHeaderView.isHidden = true
            UIView.animate(withDuration: 0.3,
                           delay: 0,
                           options: [],
                           animations: {
                self.stackView.layoutIfNeeded()
            })
            
            DispatchQueue.main.async {
                self.isHiddenTestButton.setTitle(
                    "Test isHidden false -> true",
                    for: .normal)
                self.result()
            }
        }
    }
}

