//
//  CommonNotiListCell2.swift
//  uTicketNew
//
//  Created by dongyeongkang on 2023/04/14.
//

import UIKit

class CommonNotiListCell2: UITableViewCell {
    
    static let identifier: String = String(describing: CommonNotiListCell2.self)
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "서비스 이용 약관 개정 안내드립니다."
        label.textAlignment = .left
        label.textColor = UIColor.color(.mold_116_116_116)
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "yyyy-MM-dd H:mm"
        label.textAlignment = .left
        label.textColor = UIColor.color(.mold_116_116_116)
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let newBadgeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "newBadge")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        comminit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        comminit()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    private func comminit() {
        addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(dateLabel)
        addSubview(newBadgeImageView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: newBadgeImageView.leadingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            titleLabel.heightAnchor.constraint(equalToConstant: 16),
            newBadgeImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            newBadgeImageView.centerYAnchor.constraint(equalTo: stackView.centerYAnchor),
            newBadgeImageView.widthAnchor.constraint(equalToConstant: 16),
            newBadgeImageView.heightAnchor.constraint(equalToConstant: 16)
        ])
    }
    
    func configureCell(image isHidden: Bool, titleLabel text: String?, dateLabel text2: String?) {
        contentView.backgroundColor = .white
//        contentView.backgroundColor = item.readYn ? .color(.rice_245_245_245) : .white
        newBadgeImageView.isHidden = isHidden
//        newBadgeImageView.isHidden = false//item.readYn
        titleLabel.text = text
//        titleLabel.text = item.mesg
        dateLabel.text = text2
//        dateLabel.text = item.regDt.convert2String(dateFormat: "yyyy-MM-dd H:mm")
    }
}
