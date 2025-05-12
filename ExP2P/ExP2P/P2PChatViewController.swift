//
//  P2PChatViewController.swift
//  ExP2P
//
//  Created by 강동영 on 5/1/25.
//

import UIKit

final class P2PChatViewController: UIViewController {
    private let manager: MultipeerManager
    
    init(manger: MultipeerManager) {
        self.manager = manger
        super.init(nibName: nil, bundle: nil)
        self.manager.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let textField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "메시지 입력 후 엔터"
        tf.borderStyle = .roundedRect
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    private let textView: UITextView = {
        let tv = UITextView()
        tv.isEditable = false
        tv.layer.borderWidth = 1
        tv.layer.borderColor = UIColor.lightGray.cgColor
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(textField)
        view.addSubview(textView)
        textField.delegate = self

        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            textView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 16),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
        ])
    }
    
    private func appendMessage(_ msg: String) {
        DispatchQueue.main.async {
            self.textView.text += msg + "\n"
            let bottom = NSMakeRange(self.textView.text.count - 1, 1)
            self.textView.scrollRangeToVisible(bottom)
        }
    }
}

// MARK: P2PChatViewController Method
extension P2PChatViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text, !text.isEmpty else { return false }
        let data = Data(text.utf8)
        // 연결된 피어가 있을 때만 보내기
        switch manager.send(data) {
        case .success(_):
            print("")
            appendMessage("나: \(text)")
            textField.text = ""
        case .failure(let error):
            print(error.localizedDescription)
            
        }
        return true
    }
}

// MARK: MultipeerDataDelegate Method
extension P2PChatViewController: MPSessionDelegate {
    func connectedState(_ message: String) {
        appendMessage(message)
    }
    func receiveData(peerID: String, _ data: Data) {
        if let msg = String(data: data, encoding: .utf8) {
            appendMessage("\(peerID): \(msg)")
        }
    }
}
