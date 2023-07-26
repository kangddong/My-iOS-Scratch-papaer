//
//  TwoButtonTabComponent.swift
//  Created by dongyeongkang on 2023/07/05.
//

import UIKit

protocol TwoButtonActionDelegate: AnyObject {
    func bind(oldValue: Int, newValue: Int)
}

final class TwoButtonTabComponent: UIStackView {

    
    enum TabType: Int {
        case left = 0
        case right = 1
    }
    
    private let buttonHStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        
        return stackView
    }()
    
    private let leftButton: UIButton = {
        let button = UIButton()
        button.setTitle("퇴근", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitleColor(.label, for: .normal)
        button.tag = TabType.left.rawValue
        
        return button
    }()
    
    private let rightButton: UIButton = {
        let button = UIButton()
        button.setTitle("하고싶다", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitleColor(.label, for: .normal)
        button.tag = TabType.right.rawValue
        
        return button
    }()
    
    private let tabIndicator: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        
        return view
    }()
    
    var currentTab: Int = 0
    public weak var delegate: TwoButtonActionDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureAttributes()
        addSubViews()
        addConstraints()
        configureTabIndicator()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func moveIndicator(to tab: TabType) {
        let button = tab == .left ? leftButton : rightButton
        moveIndicator(to: button)
    }
}

// MARK: Configuration Method
extension TwoButtonTabComponent {
    
    private func configureAttributes() {
        
        axis = .vertical
        alignment = .fill
        distribution = .fill
        spacing = 0
    }
    
    private func addSubViews() {
        
        addArrangedSubview(buttonHStackView)
        addArrangedSubview(tabIndicator)
        buttonHStackView.addArrangedSubview(leftButton)
        buttonHStackView.addArrangedSubview(rightButton)
    }
    
    private func addConstraints() {
        
        buttonHStackView.translatesAutoresizingMaskIntoConstraints = false
        tabIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            buttonHStackView.heightAnchor.constraint(equalToConstant: 36),
            tabIndicator.heightAnchor.constraint(equalToConstant: 2),
        ])
    }
    
    private func configureTabIndicator() {
        
        tabIndicator.frame.origin.x = leftButton.frame.origin.x
        tabIndicator.frame.size.width = leftButton.frame.size.width
    }
    
    private func configureButtons() {
        
        leftButton.addTarget(self, action: #selector(moveTab(_:)), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(moveTab(_:)), for: .touchUpInside)
    }
}

// MARK: Logic.
extension TwoButtonTabComponent {
    
    @objc
    private func moveTab(_ sender: UIButton) {
        let previousTag = currentTab
        
        currentTab = sender.tag
        moveIndicator(to: sender)
        
        delegate?.bind(oldValue: previousTag, newValue: sender.tag)
    }
    
    private func bind(oldValue: Int, newValue: Int) {
        let filterButton = [leftButton, rightButton].filter { $0?.tag == newValue }
        guard let selectedButton = filterButton.first else { return }
        
        moveIndicator(to: selectedButton)
    }
    
    private func moveIndicator(to button: UIButton) {
        
        tabIndicator.frame.size.width = button.frame.size.width
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options: []) {
            self.tabIndicator.frame.origin.x = button.frame.origin.x
            self.tabIndicator.layoutIfNeeded()
        }
    }
}
