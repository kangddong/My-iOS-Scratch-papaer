//
//  SceneDelegate.swift
//  ExNetworkFailed
//
//  Created by 강동영 on 4/14/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private var errorWindow: UIWindow?
    private var isShowingErrorView = false
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = ViewController()
        window?.makeKeyAndVisible()
        startMonitoring(scene: scene)
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        NetworkMonitor.shared.stopMonitoring()
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


    private func startMonitoring(scene: UIScene) {
        NetworkMonitor.shared.startMonitoring { [weak self] connectionStatus in
            guard let self else { return }
            switch connectionStatus {
            case .satisfied:
                self.removeNetworkErrorWindow()
            case .unsatisfied:
                self.showNetworkErrorWindow(on: scene)
            
            case .requiresConnection:
                break
            @unknown default:
                break
            }
        }
    }
    
    private func removeNetworkErrorWindow() {
        errorWindow?.resignKey()
        errorWindow = nil
        isShowingErrorView = false
    }
    
    // errorWindow에 네트워크 단절 안내 화면 띄우기
    private func showNetworkErrorWindow(on scene: UIScene) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.windowLevel = .statusBar
            window.makeKeyAndVisible()
            
            let nowNetworkView = NetworkConnectionErrorView(frame: window.bounds)
            window.addSubview(nowNetworkView)
            errorWindow = window
        }
    }
}

