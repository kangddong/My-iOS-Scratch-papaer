//
//  NFCRegistViewController.swift
//  NFCSample
//
//  Created by 강동영 on 2023/03/28.
//

import UIKit
import CoreNFC

class NFCRegistViewController: UIViewController {

    static let identifier: String = String(describing: NFCRegistViewController.self)
    
    private lazy var scanButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("Scan", for: .normal)
        button.tintColor = .white
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = .systemPink
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(scanningNFC), for: .touchUpInside)
        return button
    }()
    
    private let logLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "log start"
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.tintColor = .black
        label.font = UIFont.systemFont(ofSize:  12)
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var serialNumber: String = ""
    private var logText: String = ""
    private var nfcSession: NFCTagReaderSession?
    private var isScanning: Bool = false // 스캔하기 중복 입력방지 flag
    
    private var successImpact: UIImpactFeedbackGenerator?
    private var failImpact:UIImpactFeedbackGenerator?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        _setNavi()
        _addSubViews()
        _setConstraint()
    }
    
    private func _setNavi() {
        title = "NFC Card Regist"
        navigationItem.setRightBarButton(
            UIBarButtonItem(
                title: "Clear",
                style: .plain,
                target: self,
                action: #selector(_clearView)),
            animated: true)
    }
    
    @objc
    private func _clearView() {
        print(#function)
        logLabel.text = ""
    }
    
    private func _addSubViews() {
        view.addSubview(scanButton)
        view.addSubview(logLabel)
    }
    
    private func _setConstraint() {
        
        NSLayoutConstraint.activate([
            logLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            logLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            logLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            logLabel.bottomAnchor.constraint(equalTo: scanButton.topAnchor),
            
            scanButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            scanButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            scanButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            scanButton.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
    
    

}

extension NFCRegistViewController {
    
    @objc
    private func scanningNFC() {
        guard !isScanning else { return }
        isScanning = true
        startRegist()
    }
    
    private func startRegist() {
        guard NFCTagReaderSession.readingAvailable else {
            let alertController = UIAlertController(
                title: "Scanning Not Supported",
                message: "This device doesn't support tag scanning.",
                preferredStyle: .alert
            )
            alertController.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { (_) in
                self.navigationController?.popViewController(animated: true)
            }))
            
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        nfcSession = NFCTagReaderSession(pollingOption: [.iso14443, .iso15693], delegate: self)
        nfcSession?.alertMessage = "Please recognize NFC Card"
        nfcSession?.begin()

    }
}

// MARK: NFCTagReaderSessionDelegate Method
extension NFCRegistViewController: NFCTagReaderSessionDelegate {
    func tagReaderSessionDidBecomeActive(_ session: NFCTagReaderSession) {
        print(#function)
        DispatchQueue.main.async {
            self.logLabel.text! += "\(#function)\n"
        }
    }
    
    func tagReaderSession(_ session: NFCTagReaderSession, didInvalidateWithError error: Error) {
        
        if let readerError = error as? NFCReaderError {
            // Show an alert when the invalidation reason is not because of a
            // successful read during a single-tag read session, or because the
            // user canceled a multiple-tag read session from the UI or
            // programmatically using the invalidate method call.
            if (readerError.code != .readerSessionInvalidationErrorFirstNDEFTagRead)
                && (readerError.code != .readerSessionInvalidationErrorUserCanceled) {
                
            }
            print(#function, readerError.localizedDescription)
            DispatchQueue.main.async {
                self.logLabel.text! += "\(#function + readerError.localizedDescription)\n"
            }
            
        }
        
        // NFC 세션이 종료될 때 타이머도 같이 할당 해제해주기 !
        self.nfcSession = nil
        isScanning = false
    }
    
    func tagReaderSession(_ session: NFCTagReaderSession, didDetect tags: [NFCTag]) {
        print(#function)
        DispatchQueue.main.async {
            self.logLabel.text! += "\(#function) tags.count = \(tags.count)\n"
        }
        print("tag count = \(tags.count)")
        
        for tag in tags {
            print("tag = \(tag)")
            DispatchQueue.main.async {
                self.logLabel.text! += "tag = \(tag)\n"
            }
            
        }
        
        func rePolling(text: String, isSuccess: Bool) {
            print(#function)
            DispatchQueue.main.async {
                self.logLabel.text! += "\(#function)\n"
            }
            
            session.alertMessage = text
            
            let time = isSuccess ? 0.2 : 2
            let message = "Please recognize NFC Card"
            
            DispatchQueue.main.async {
                switch isSuccess {
                case true:
                    self.successImpact?.prepare()
                    self.successImpact?.impactOccurred()
                case false:
                    self.failImpact?.prepare()
                    self.failImpact?.impactOccurred()
                }
            }
            DispatchQueue.global().asyncAfter(deadline: .now() + time, execute: {
                session.alertMessage = message
                session.restartPolling()
            })
        }
        //태그가 2장 이상 인식되었을 때
        if tags.count > 1 {
            if let tag = tags.first {
                switch tag {
                    //[NFCTag]에 append 되는 순서는
                case .iso15693, .feliCa, .miFare:
                    let text = "More than 1 tag is detected, please remove all tags and try again."
                    rePolling(text: text, isSuccess: false)
                    return
                    // iso7816은 스마트 카드(IC 칩)에 대한 표준
                case .iso7816:
                    debugPrint("two tag bug first is iso7816")
                    
                @unknown default:
                    let text = "Fail to read NFC Card"
                    rePolling(text: text, isSuccess: false)
                    return
                }
            }
        }
        
        guard let tag = tags.first else {
            let text = "Tag is not detected, please remove all tags and try again."
            rePolling(text: text, isSuccess: false)
            return
        }
        
        guard let id = self.readTagID(tag) else {
            let text = "Fail to read NFC Card"
            rePolling(text: text, isSuccess: false)
            return
        }
        serialNumber = id
        session.alertMessage = "Success" //read 성공
        session.invalidate()
        
//        self.isValidRegist()
    }
    
    // NFC 종류별로 UID 얻어오는 부분
    private func readTagID(_ tag: NFCTag) -> String? {
        print(#function, tag)
        DispatchQueue.main.async {
            self.logLabel.text! += "\(#function) tag = \(tag)\n"
        }
        
        switch tag {
        case let .miFare(info):
            
            let tagUIDData = info.identifier
            var byteData: [UInt8] = []
            tagUIDData.withUnsafeBytes { byteData.append(contentsOf: $0) }
            var uidString = ""
            for byte in byteData {
                let decimalNumber = String(byte, radix: 16)
                if decimalNumber.count == 1 {
                    uidString.append("0")
                }
                uidString.append(decimalNumber)
            }
            print("iso14443/miFare uidString = \(uidString)")
            return uidString
        case let .iso7816(info):
            
            let tagUIDData = info.identifier
            var byteData: [UInt8] = []
            tagUIDData.withUnsafeBytes { byteData.append(contentsOf: $0) }
            var uidString = ""
            for byte in byteData {
                let decimalNumber = String(byte, radix: 16)
                if decimalNumber.count == 1 {
                    uidString.append("0")
                }
                uidString.append(decimalNumber)
            }
            print("iso7816 uidString = \(uidString)")
            return uidString
        case let .iso15693(info):
            
            let tagUIDData = info.identifier
            var byteData: [UInt8] = []
            tagUIDData.withUnsafeBytes { byteData.append(contentsOf: $0) }
            var uidString = ""
            for byte in byteData {
                let decimalNumber = String(byte, radix: 16)
                if decimalNumber.count == 1 {
                    uidString.append("0")
                }
                uidString.append(decimalNumber)
            }
            print("iso15693 uidString = \(uidString)")
            return uidString
        case let .feliCa(info):
            
            let tagUIDData = info.currentIDm // currentIDm == identifier
            var byteData: [UInt8] = []
            tagUIDData.withUnsafeBytes { byteData.append(contentsOf: $0) }
            var uidString = ""
            for byte in byteData {
                let decimalNumber = String(byte, radix: 16)
                if decimalNumber.count == 1 {
                    uidString.append("0")
                }
                uidString.append(decimalNumber)
            }
            return uidString
        }
    }
}
