//
//  P2PChatViewController.swift
//  ExP2P
//
//  Created by 강동영 on 5/1/25.
//

import UIKit
import MultipeerConnectivity

class P2PChatViewController: UIViewController {
    // 1) P2P 식별자
    private let serviceType = "p2p-chat-demo"
    private var peerID: MCPeerID!
    private var session: MCSession!
    private var advertiser: MCNearbyServiceAdvertiser!
    private var browser: MCNearbyServiceBrowser!

    // 2) UI
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
        setupP2P()
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

    private func setupP2P() {
        // PeerID & Session
        peerID = MCPeerID(displayName: UIDevice.current.name)
        session = MCSession(peer: peerID,
                            securityIdentity: nil,
                            encryptionPreference: .optional)
        session.delegate = self

        // Advertiser: 나를 광고
        advertiser = MCNearbyServiceAdvertiser(peer: peerID,
                                               discoveryInfo: nil,
                                               serviceType: serviceType)
        advertiser.delegate = self
        advertiser.startAdvertisingPeer()

        // Browser: 주변 탐색
        browser = MCNearbyServiceBrowser(peer: peerID,
                                         serviceType: serviceType)
        browser.delegate = self
        browser.startBrowsingForPeers()
    }

    private func appendMessage(_ msg: String) {
        DispatchQueue.main.async {
            self.textView.text += msg + "\n"
            let bottom = NSMakeRange(self.textView.text.count - 1, 1)
            self.textView.scrollRangeToVisible(bottom)
        }
    }
}

// MARK: - UITextFieldDelegate
extension P2PChatViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text, !text.isEmpty else { return false }
        let data = Data(text.utf8)
        // 연결된 피어가 있을 때만 보내기
        if !session.connectedPeers.isEmpty {
            do {
                try session.send(data,
                                 toPeers: session.connectedPeers,
                                 with: .reliable)
                appendMessage("나: \(text)")
                textField.text = ""
            } catch {
                print("✉️ 전송 실패:", error)
            }
        } else {
            appendMessage("⚠️ 연결된 피어가 없습니다.")
        }
        return true
    }
}

// MARK: - MCSessionDelegate
extension P2PChatViewController: MCSessionDelegate {
    func session(_ session: MCSession,
                 peer peerID: MCPeerID,
                 didChange state: MCSessionState) {
        switch state {
        case .connected:
            print("✅ 연결됨 with \(peerID.displayName)")
            appendMessage("✅ \(peerID.displayName) 연결됨")
        case .connecting:
            print("⏳ 연결 중 with \(peerID.displayName)")
        case .notConnected:
            print("❌ 끊김 with \(peerID.displayName)")
            appendMessage("❌ \(peerID.displayName) 연결 끊김")
        @unknown default: break
        }
    }

    func session(_ session: MCSession,
                 didReceive data: Data,
                 fromPeer peerID: MCPeerID) {
        if let msg = String(data: data, encoding: .utf8) {
            appendMessage("\(peerID.displayName): \(msg)")
        }
    }

    // unused
    func session(_ session: MCSession,
                 didReceive stream: InputStream,
                 withName streamName: String,
                 fromPeer peerID: MCPeerID) {}
    func session(_ session: MCSession,
                 didStartReceivingResourceWithName resourceName: String,
                 fromPeer peerID: MCPeerID,
                 with progress: Progress) {}
    func session(_ session: MCSession,
                 didFinishReceivingResourceWithName resourceName: String,
                 fromPeer peerID: MCPeerID,
                 at localURL: URL?,
                 withError error: Error?) {}
}

// MARK: - MCNearbyServiceAdvertiserDelegate
extension P2PChatViewController: MCNearbyServiceAdvertiserDelegate {
    // 초대 받으면 바로 수락
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser,
                    didReceiveInvitationFromPeer peerID: MCPeerID,
                    withContext context: Data?,
                    invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        print("📲 초대 받음 from \(peerID.displayName)")
        invitationHandler(true, session)
    }
}

// MARK: - MCNearbyServiceBrowserDelegate
extension P2PChatViewController: MCNearbyServiceBrowserDelegate {
    // 피어 발견 시 자동 초대
    func browser(_ browser: MCNearbyServiceBrowser,
                 foundPeer peerID: MCPeerID,
                 withDiscoveryInfo info: [String : String]?) {
        print("🔍 발견: \(peerID.displayName), 초대 전송")
        browser.invitePeer(peerID,
                           to: session,
                           withContext: nil,
                           timeout: 30)
    }

    func browser(_ browser: MCNearbyServiceBrowser,
                 lostPeer peerID: MCPeerID) {
        print("❌ 잃음: \(peerID.displayName)")
    }
}
