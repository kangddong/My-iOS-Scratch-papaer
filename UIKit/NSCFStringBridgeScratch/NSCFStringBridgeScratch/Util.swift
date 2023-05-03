//
//  Util.swift
//  NSCFStringBridgeScratch
//
//  Created by dongyeongkang on 2023/05/03.
//

import UIKit

class Util {
    
    static func setRootToMain(window: UIWindow?) {
        
        var cWindow = window
        
        if window == nil {
            let sceneDelegate = UIApplication.shared.delegate as? SceneDelegate
            cWindow = sceneDelegate?.window
        }
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainTab")
        let navi = UINavigationController(rootViewController: vc)
//        let navi = SiksinNavigation(rootViewController: vc)
        
        cWindow?.rootViewController = navi
        cWindow?.makeKeyAndVisible()
    }
}
