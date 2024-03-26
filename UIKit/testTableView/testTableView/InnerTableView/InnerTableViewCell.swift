//
//  InnerTableViewCell.swift
//  testTableView
//
//  Created by 강동영 on 3/27/24.
//

import UIKit

final class InnerTableViewCell: UITableViewCell {
    static let reuseIdentifier: String = String(describing: InnerTableViewCell.self)
    
    private let titleLabel: UILabel = {
        let label: UILabel = UILabel(frame: .zero)
        label.text = "test"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let moveButton: UIButton = {
        let button: UIButton = UIButton(frame: .zero)
        button.setTitle("Test", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension InnerTableViewCell {
    private func addSubviews() {
        [titleLabel, moveButton].forEach {
            self.contentView.addSubview($0)
        }
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(greaterThanOrEqualTo: moveButton.leadingAnchor, constant: 16),
            titleLabel.bottomAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            
            moveButton.topAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.topAnchor, constant: 16),
            moveButton.trailingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            moveButton.bottomAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.bottomAnchor, constant: -16),
        ])
    }
}
