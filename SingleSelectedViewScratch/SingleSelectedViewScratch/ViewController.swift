//
//  ViewController.swift
//  SingleSelectedViewScratch
//
//  Created by dongyeongkang on 2023/06/07.
//

import UIKit

class ViewController: UIViewController {

    enum ComplainType: Int, CaseIterable {
        case good = 0
        case bad
        case other
    }
    
    @IBOutlet weak var goodView: UIView!
    @IBOutlet weak var goodImageView: UIImageView!
    @IBOutlet weak var goodLabel: UILabel!
    
    @IBOutlet weak var badView: UIView!
    @IBOutlet weak var badImageView: UIImageView!
    @IBOutlet weak var badLabel: UILabel!
    
    @IBOutlet weak var otherView: UIView!
    @IBOutlet weak var otherImageView: UIImageView!
    @IBOutlet weak var otherLabel: UILabel!
    
    
    private let goodColor = UIColor(red: 255/255,
                            green: 176/255,
                            blue: 0/255,
                            alpha: 1.0)
    
    private let badColor = UIColor(red: 234/255,
                           green: 64/255,
                           blue: 64/255,
                           alpha: 1.0)
    
    private let otherColor = UIColor(red: 51/255,
                             green: 148/255,
                             blue: 238/255,
                             alpha: 1.0)
    
    private let onImages: [String] = ["goodEmojiOn", "badEmojiOn", "otherEmojiOn"]
    private let offImages: [String] = ["goodEmojiOff", "badEmojiOff", "otherEmojiOff"]
    
    private lazy var onColors: [UIColor] = [goodColor, badColor, otherColor]
    private let offColor = UIColor(red: 216/255,
                           green: 216/255,
                           blue: 216/255,
                           alpha: 1.0)
    
    private lazy var touchViewArray: [UIView] = [
        goodView,
        badView,
        otherView,
    ]
    private var commentArray: [(commentView: UIImageView, commentLabel: UILabel)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configGesture()
    }


}

extension ViewController {
    
    private func configGesture() {

        goodView.tag = ComplainType.good.rawValue
        badView.tag = ComplainType.bad.rawValue
        otherView.tag = ComplainType.other.rawValue
        
        touchViewArray.forEach {
            let tap = UITapGestureRecognizer(target: self, action: #selector(changeStatus(_:)))
            $0.addGestureRecognizer(tap)
        }
        
        
        commentArray.append((commentView: goodImageView, commentLabel: goodLabel))
        commentArray.append((commentView: badImageView, commentLabel: badLabel))
        commentArray.append((commentView: otherImageView, commentLabel: otherLabel))
    }
    
    @objc
    private func changeStatus(_ recognizer: UITapGestureRecognizer) {
        for index in 0...2 {
            if recognizer.view == touchViewArray[index] {
                
                commentArray[index].commentView.image = UIImage(named: onImages[index])
                commentArray[index].commentLabel.textColor = onColors[index]
            } else {
                
                commentArray[index].commentView.image = UIImage(named: offImages[index])
                commentArray[index].commentLabel.textColor = offColor
            }
        }
    }
}
