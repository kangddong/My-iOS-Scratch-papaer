//
//  MainTabBarVC.swift
//  NSCFStringBridgeScratch
//
//  Created by dongyeongkang on 2023/05/03.
//

import UIKit

final class MainTabBarVC: UITabBarController {

    enum MainTab: String,CaseIterable {
        case testA = "Test A"
        case testB = "Test B"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setTabBarUI()
        setNaviStyle(type: .testA)
    }
    

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let index = tabBar.items?.firstIndex(of: item) else { return }
        let tabType = MainTab.allCases[index]
        
        setNaviStyle(type: tabType)
    }

    private func setTabBarUI() {
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = nil
        UITabBar.appearance().backgroundColor = .white
        
        // layer - gray
        let grayLayer = CALayer()
        
        grayLayer.backgroundColor = UIColor(red: 221/255, green: 221/255, blue: 221/255, alpha: 1.0).cgColor
        grayLayer.frame = CGRect(x: 0, y: -1, width: view.frame.width, height: 1)
        tabBar.layer.addSublayer(grayLayer)
        
        tabBar.tintColor = UIColor(red: 254/255, green: 102/255, blue: 0/255, alpha: 1.0)
        tabBar.unselectedItemTintColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1.0)
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = 0.05
        tabBar.layer.shadowOffset = CGSize(width: 0, height: -2)
        tabBar.layer.shadowRadius = 3
        tabBar.layer.shouldRasterize = true
        tabBar.layer.rasterizationScale = UIScreen.main.scale
        tabBar.layer.shadowPath = UIBezierPath(rect: tabBar.bounds).cgPath
    }
    
    private func setNaviStyle(type: MainTab) {
        
        title = nil
        navigationItem.leftBarButtonItems = nil
        navigationItem.rightBarButtonItems = nil
        navigationItem.titleView = nil
        
        switch type {
        case .testA:
            self.title = type.rawValue
        case .testB:
            self.title = type.rawValue
        }
    }
}
