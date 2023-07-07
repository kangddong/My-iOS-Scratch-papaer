//
//  ViewController.swift
//  refactoringCustomTabView
//
//  Created by dongyeongkang on 2023/07/07.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var tabIndicator: UIView!
    
    // MARK: UIPageViewController Property
    lazy var pageViewController: UIPageViewController = {
        let vc = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)

        return vc
    }()
    
    lazy var vcArray: [UIViewController] = {
        return [leftVC, rightVC]
    }()
    
    lazy var leftVC: UIViewController = {
        return vcInstance(name: "LeftTabViewController") as! LeftTabViewController
    }()
    
    lazy var rightVC: UIViewController = {
        return vcInstance(name: "RightTabViewController") as! RightTabViewController
    }()
    
    private func vcInstance(name: String) -> UIViewController{
        return UIStoryboard(name: "Tab", bundle: nil).instantiateViewController(withIdentifier: name)
    }
    
    private var currentPage: Int = 0 {
        didSet {
            bind(oldValue: oldValue, newValue: currentPage)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initPageViewController()
        configureTabIndicator()
        configureButtons()
    }
}

extension ViewController {
    
    private func initPageViewController() {
        
        addChild(pageViewController)
        container.addSubview(pageViewController.view)
        
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageViewController.view.topAnchor.constraint(equalTo: container.topAnchor),
            pageViewController.view.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            pageViewController.view.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            pageViewController.view.bottomAnchor.constraint(equalTo: container.bottomAnchor),
        ])
        
        pageViewController.didMove(toParent: self)
        pageViewController.delegate = self
        pageViewController.dataSource = self
        
        guard let leftVC = vcArray.first as? LeftTabViewController else { return }
        guard let rightVC = vcArray.last as? RightTabViewController else { return }
        
        pageViewController.setViewControllers([leftVC], direction: .forward, animated: true, completion: nil)
    }
    
    private func configureTabIndicator() {
        
        tabIndicator.frame.origin.x = leftButton.frame.origin.x
        tabIndicator.frame.size.width = rightButton.frame.size.width
    }
    
    private func configureButtons() {
        
        leftButton.addTarget(self, action: #selector(moveTab(_:)), for: .touchUpInside)
        leftButton.tag = 0
        rightButton.addTarget(self, action: #selector(moveTab(_:)), for: .touchUpInside)
        rightButton.tag = 1
    }
    
    @objc
    private func moveTab(_ sender: UIButton) {
        currentPage = sender.tag
        moveIndicator(to: sender)
    }
    
    private func moveIndicator(to button: UIButton) {
        
        tabIndicator.frame.size.width = button.frame.size.width
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options: []) {
            self.tabIndicator.frame.origin.x = button.frame.origin.x
            self.tabIndicator.layoutIfNeeded()
        }
    }
    
    private func bind(oldValue: Int, newValue: Int) {

        let direction: UIPageViewController.NavigationDirection = oldValue < newValue ? .reverse : .forward
        pageViewController.setViewControllers([vcArray[currentPage]], direction: direction, animated: true, completion: nil)
        
        let filterButton = [leftButton, rightButton].compactMap { $0 }.filter { $0.tag == newValue }
        guard let selectedButton = filterButton.first else { return }
        
        moveIndicator(to: selectedButton)
    }
}

// MARK: UIPageViewControllerDelegate, UIPageViewControllerDataSource Method
extension ViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = vcArray.firstIndex(of: viewController) else { return nil }

        let prevIndex = vcIndex - 1
        guard prevIndex >= 0 else { return nil }
        guard vcArray.count > prevIndex else { return nil }

//        return vcArray[prevIndex]
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = vcArray.firstIndex(of: viewController) else { return nil }

        let nextIndex = vcIndex + 1
        guard nextIndex < vcArray.count else { return nil }
        guard vcArray.count > nextIndex else { return nil }

//        return vcArray[nextIndex]
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let currentVC = pageViewController.viewControllers?.first, let currentIndex = vcArray.firstIndex(of: currentVC) else { return }
        print(#function)
        currentPage = currentIndex
    }
}
