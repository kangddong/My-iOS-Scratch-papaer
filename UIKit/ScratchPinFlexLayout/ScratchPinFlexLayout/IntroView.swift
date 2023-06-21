//
//  IntroView.swift
//  ScratchPinFlexLayout
//
//  Created by 강동영 on 2023/06/21.
//

import UIKit
import FlexLayout
import PinLayout

class IntroView: UIView {
    fileprivate let rootFlexContainer = UIView()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        
        let imageView = UIImageView(image: UIImage(named: ""))
        
        let segementedControl = UISegmentedControl(items: ["Intro", "Arex", "Swift"])
        segementedControl.selectedSegmentIndex = 0
        
        let label = UILabel()
        label.text = "저녁으로 치킨을 먹어서 배가 부르네요"
        label.numberOfLines = 0
        
        let bottomLabel = UILabel()
        bottomLabel.text = "사실 어제 저녁에 먹고 남은 치킨이라 맛이 조금 아쉬웠어요"
        bottomLabel.numberOfLines = 0
        
        rootFlexContainer.flex.direction(.column).padding(12).define { flex in
            flex.addItem().direction(.row).define { flex in
                flex.addItem(imageView).width(100).aspectRatio(of: imageView)
                
                flex.addItem().direction(.column).paddingLeft(12).grow(1).shrink(1).define { flex in
                    flex.addItem(segementedControl).marginBottom(12).grow(1)
                    flex.addItem(label)
                }
            }
            
            flex.addItem().height(1).marginTop(12).backgroundColor(.lightGray)
            flex.addItem(bottomLabel).marginTop(12)
        }
        
        addSubview(rootFlexContainer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        rootFlexContainer.pin.top().horizontally().margin(pin.safeArea)
        rootFlexContainer.flex.layout(mode: .adjustHeight)
    }
}
