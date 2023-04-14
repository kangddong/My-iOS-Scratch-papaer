//
//  AlarmListCell.swift
//  uTicketNew
//
//  Created by dongyeongkang on 2023/04/13.
//

import UIKit

final class AlarmListCell: CommonNotiListCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func configureCell(item: AlarmInfo) {
        
        contentView.backgroundColor = .red
//        contentView.backgroundColor = item.readYn ? .color(.rice_245_245_245) : .white
        newBadgeImageView.isHidden = false//item.readYn
        titleLabel.text = item.mesg
        dateLabel.text = item.regDt.convert2String(dateFormat: "yyyy-MM-dd H:mm")
    }

}
