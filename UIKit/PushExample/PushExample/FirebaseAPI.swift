//
//  FirebaseAPI.swift
//  PushExample
//
//  Created by kimjiseob on 2020/05/11.
//

import Foundation
import FirebaseMessaging

class FirebaseAPI: NSObject {
    static let shared = FirebaseAPI.init()
    
    private override init() {
        super.init()
        fcmInit()
    }
    
}

// MARK: - FCM
extension FirebaseAPI {
    private func fcmInit() {
        Messaging.messaging().delegate = self
    }
    
    /// APNS 토큰 업데이트
    func updateAPNSToken(_ token: Data) {
        Messaging.messaging().apnsToken = token
        
        let convertedToken:String = String(format: "%@", token as CVarArg).trimmingCharacters(in: CharacterSet(charactersIn: "<>")).replacingOccurrences(of: " ", with: "")
        print("convertedToken: \(convertedToken)")
        
    }
    
    /// FCM 갱신
    func refreshToken(complete: @escaping ((_ key: String?)->())) {
        
        Messaging.messaging().token { token, error in
            if let error = error {
                print("Error fetching FCM registration token: \(error)")
                complete(nil)
            } else if let token = token {
                print("FCM registration token: \(token)")
                complete(token)
            }
        }
    }
    
    /// FCM 토큰 삭제
    func deleteToken(complete: ((Bool)->())?) {
        
        Messaging.messaging().deleteToken { error in
            switch error == nil {
            case true:
                // Success
                complete?(true)
            case false:
                complete?(false)
            }
        }
    }
    
    /// FCM Token 서버에 전송
    func postPushKey(pushKey: String, complete: ((Bool)->())?) {
        
    }
}

// MARK: - FCM Delegate
extension FirebaseAPI: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {

        print("FCM Token: \(fcmToken)")
        
//        self.postPushKey(pushKey: fcmToken, complete: nil)
    }
}
