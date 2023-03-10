//
//  ViewController2.swift
//  thenPractice
//
//  Created by dongyeongkang on 2022/12/15.
//

import UIKit
import Tabman
import Pageboy

class ViewController2: TabmanViewController {
    
    enum Tab: String, CaseIterable {
        case ViewController
        case ViewController3
    }
    
    private let tabItems = Tab.allCases.map({ BarItem(for: $0) })
    private lazy var viewControllers = tabItems.compactMap({ $0.makeViewController() })
    
    let tab: ViewController2.Tab = .ViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        
        let bar = TMBar.ButtonBar()
        bar.layout.transitionStyle = .snap
        
        addBar(bar.systemBar(), dataSource: self, at: .top)
        
    }
}

extension ViewController2: PageboyViewControllerDataSource, TMBarDataSource {
    
    func numberOfViewControllers(in pageboyViewController: Pageboy.PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: Pageboy.PageboyViewController, at index: Pageboy.PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: Pageboy.PageboyViewController) -> Pageboy.PageboyViewController.Page? {
        
        return nil
    }
    
    func barItem(for bar: Tabman.TMBar, at index: Int) -> Tabman.TMBarItemable {
        let title = "Page \(index)"
        return TMBarItem(title: title)
    }
}

class BarItem: TMBarItemable {
    
    let tab: ViewController2.Tab
    
    init(for tab: ViewController2.Tab) {
        self.tab = tab
    }
    
    private var _title: String? {
        return tab.rawValue.capitalized
    }
    var title: String? {
        get {
            return _title
        } set {}
    }
    
    private var _image: UIImage? {
        return UIImage(named: "ic_\(tab.rawValue)")
    }
    var image: UIImage? {
        get {
            return _image
        } set {}
    }
    var selectedImage: UIImage?
    var badgeValue: String?
    
    func makeViewController() -> UIViewController? {
        let identifier: String
        switch tab {
        case .ViewController:
            identifier = "ViewController"
        case .ViewController3:
            identifier = "ViewController3"
        }
        
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: identifier)
    }
}
