//
//  AlarmListCell2.swift
//  uTicketNew
//
//  Created by dongyeongkang on 2023/04/14.
//

import UIKit

final class AlarmListCell2: CommonNotiListCell2 {

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    public func configureCell(item: AlarmInfo) {
//
//        contentView.backgroundColor = .white
////        contentView.backgroundColor = item.readYn ? .color(.rice_245_245_245) : .white
//        newBadgeImageView.isHidden = false//item.readYn
//        titleLabel.text = item.mesg
//        dateLabel.text = item.regDt.convert2String(dateFormat: "yyyy-MM-dd H:mm")
//    }
    
    func setData(item: AlarmInfo) {
        let isHidden = false
        let text = item.mesg
        let text2 = item.regDt.convert2String(dateFormat: "yyyy-MM-dd H:mm")
        super.configureCell(image: isHidden, titleLabel: text, dateLabel: text2)
    }
//    override func configureCell(image isHidden: Bool, titleLabel text: String?, dateLabel text2: String?) {
//        super.configureCell(image: isHidden, titleLabel: text, dateLabel: text2)
//    }

}
