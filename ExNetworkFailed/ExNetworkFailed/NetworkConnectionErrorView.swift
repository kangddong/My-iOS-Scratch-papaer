//
//  NetworkConnectionErrorView.swift
//  ExNetworkFailed
//
//  Created by 강동영 on 4/14/25.
//


import UIKit

final class NetworkConnectionErrorView: UIView {
    private let stackView: UIStackView = {
        let stackView: UIStackView = .init(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    
    private let imageView: UIImageView = {
        let imageView: UIImageView = .init(image: UIImage(systemName: "icloud.slash.fill"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label: UILabel = .init(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.design(
            text: "앗! 오프라인 상태인 것 같아요",
            textColor: .gray,
            font: UIFont.systemFont(ofSize: 18, weight: .semibold),
            textAlignment: .center
        )
        return label
    }()
    private let descriptionLabel: UILabel = {
        let label: UILabel = .init(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.design(
            text: "앱을 이용하려면 인터넷 연결이 필요해요.\nWi-Fi 혹은 데이터 네트워크 연결 후\n아래의 새로고침 버튼을 눌러 보세요.",
            textColor: .gray,
            font: UIFont.systemFont(ofSize: 16, weight: .regular),
            textAlignment: .center,
            numberOfLines: 3
        )
        label.setLineSpacing(spacing: 10)
        label.textAlignment = .center
        return label
    }()
    let refreshButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        self.backgroundColor = UIColor.white.withAlphaComponent(0.998)
        
        addSubview(stackView)
        [imageView, titleLabel, descriptionLabel].forEach {
            stackView.addArrangedSubview($0)
        }
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            stackView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
        ])
    }
    
    private func configureView() {
//        var config = UIButton.Configuration.filled()
//        config.title = "새로고침"
//        config.baseBackgroundColor = ColorStyle.textBlack
//        config.baseForegroundColor = ColorStyle.textWhite
//        config.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 54, bottom: 15, trailing: 54)
//        config.background.cornerRadius = 10
//        refreshButton.configuration = config
    }
}

extension UILabel {
    func design(text: String = "",
                textColor: UIColor = .gray,
                font: UIFont = .systemFont(ofSize: 14),
                textAlignment: NSTextAlignment = .left,
                numberOfLines: Int = 1) {
        self.text = text
        self.textColor = textColor
        self.font = font
        self.textAlignment = textAlignment
        self.numberOfLines = numberOfLines
    }
    
    func setLineSpacing(spacing: CGFloat) {
        guard let text = text else { return }
        
        let attributeString = NSMutableAttributedString(string: text)
        let style = NSMutableParagraphStyle()
        style.lineSpacing = spacing
        attributeString.addAttribute(.paragraphStyle,
                                     value: style,
                                     range: NSRange(location: 0, length: attributeString.length))
        attributedText = attributeString
    }
}
