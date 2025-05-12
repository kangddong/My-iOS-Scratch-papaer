//
//  MultipeerManager.swift
//  ExP2P
//
//  Created by 강동영 on 5/12/25.
//

import MultipeerConnectivity

protocol MPSessionDelegate: AnyObject {
    func connectedState(_ message: String)
    func receiveData(peerID: String, _ data: Data)
}

final class MultipeerManager: NSObject {
    enum MultipeerError: Error {
        case notConnected
        case failSend(Error)
    }
    
    private let serviceType: String
    private let peerID: MCPeerID
    private let session: MCSession
    private let advertiser: MCNearbyServiceAdvertiser
    private let browser: MCNearbyServiceBrowser
    
    weak var delegate: MPSessionDelegate?
    
    init(serviceType: String, name: String) {
        self.serviceType = serviceType
        self.peerID = MCPeerID(displayName: name)
        session = MCSession(peer: peerID,
                            securityIdentity: nil,
                            encryptionPreference: .optional)
        // Advertiser: 나를 광고
        advertiser = MCNearbyServiceAdvertiser(peer: peerID,
                                               discoveryInfo: nil,
                                               serviceType: serviceType)
        // Browser: 주변 탐색
        browser = MCNearbyServiceBrowser(peer: peerID,
                                         serviceType: serviceType)
        super.init()
        setupP2P()
    }
    
    deinit {
        session.disconnect()
        advertiser.stopAdvertisingPeer()
        browser.stopBrowsingForPeers()
    }
    
    public func send(_ data: Data) -> Result<Void, Error> {
        if !session.connectedPeers.isEmpty {
            do {
                try session.send(data, toPeers: session.connectedPeers, with: .reliable)
                return .success(())
            } catch {
                print("✉️ 전송 실패:", error)
                return .failure(MultipeerError.failSend(error))
            }
        } else {
            return .failure(MultipeerError.notConnected)
        }
    }
    
    private func setupP2P() {
        session.delegate = self
        
        advertiser.delegate = self
        advertiser.startAdvertisingPeer()
        
        browser.delegate = self
        browser.startBrowsingForPeers()
    }
}

// MARK: - MCSessionDelegate
extension MultipeerManager: MCSessionDelegate {
    func session(_ session: MCSession,
                 peer peerID: MCPeerID,
                 didChange state: MCSessionState) {
        switch state {
        case .connected:
            print("✅ 연결됨 with \(peerID.displayName)")
            delegate?.connectedState("✅ \(peerID.displayName) 연결됨")
        case .connecting:
            print("⏳ 연결 중 with \(peerID.displayName)")
            delegate?.connectedState("⏳ 연결 중 with \(peerID.displayName)")
        case .notConnected:
            print("❌ 끊김 with \(peerID.displayName)")
            delegate?.connectedState("❌ \(peerID.displayName) 연결 끊김")
        @unknown default: break
        }
    }

    func session(_ session: MCSession,
                 didReceive data: Data,
                 fromPeer peerID: MCPeerID) {
        delegate?.receiveData(peerID: peerID.displayName, data)
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
extension MultipeerManager: MCNearbyServiceAdvertiserDelegate {
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
extension MultipeerManager: MCNearbyServiceBrowserDelegate {
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
