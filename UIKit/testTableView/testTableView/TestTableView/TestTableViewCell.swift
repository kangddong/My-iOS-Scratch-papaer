//
//  TestTableViewCell.swift
//  testTableView
//
//  Created by 강동영 on 3/27/24.
//

import UIKit

final class TestTableViewCell: UITableViewCell {
    static let reuseIdentifier: String = "reuseIdentifier"
    
    let testLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 16.0, left: 16, bottom: 16, right: 16))
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        print("init")
        self.contentView.addSubview(testLabel)
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.red.cgColor
        let bottomAnchor = testLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0)
//        bottomAnchor.priority = UILayoutPriority(1000)
        NSLayoutConstraint.activate([
            testLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20),
            testLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            testLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),
            bottomAnchor,
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setData(title: String) {
        testLabel.text = title
    }
}
