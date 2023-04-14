//
//  CommonNotiListCell.swift
//  uTicketNew
//
//  Created by dongyeongkang on 2023/04/13.
//

import UIKit

class CommonNotiListCell: UITableViewCell {

    static let identifier: String = String(describing: CommonNotiListCell.self)
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var newBadgeImageView: UIImageView!
    
    @IBOutlet weak var rootViewFromNib: UIView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        Bundle(for: CommonNotiListCell.self).loadNibNamed("CommonNotiListCell", owner: self, options: nil)
        rootViewFromNib.frame = bounds
        rootViewFromNib.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        rootViewFromNib.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(rootViewFromNib)

        NSLayoutConstraint.activate([
            rootViewFromNib.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            rootViewFromNib.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            rootViewFromNib.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            rootViewFromNib.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }

}
