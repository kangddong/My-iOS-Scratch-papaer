//
//  SceneDelegate.swift
//  ExP2P
//
//  Created by 강동영 on 5/1/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
       
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = P2PChatViewController(
            manger: MultipeerManager(
                serviceType: "p2p-chat-demo",
                name: UIDevice.current.name
            )
        )
        window?.makeKeyAndVisible()
    }

}

