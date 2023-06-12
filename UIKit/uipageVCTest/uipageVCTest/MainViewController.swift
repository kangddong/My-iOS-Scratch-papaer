//
//  MainViewController.swift
//  uipageVCTest
//
//  Created by dongyeongkang on 2023/06/12.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var sectionAButton: UIButton!
    @IBOutlet weak var sectionBButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    
    lazy var pageViewController: UIPageViewController = {
        let vc = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)

        return vc
    }()
    
    lazy var vcArray: [UIViewController] = {
        return [
            firstVC,
            secondVC,
            vcInstance(name: "ThirdPageVC"),
        ]
    }()
    
    lazy var firstVC: UIViewController = {
        return vcInstance(name: "FirstPageVC")
    }()
    
    lazy var secondVC: UIViewController = {
        return vcInstance(name: "SecondPageVC")
    }()
    
    private func vcInstance(name: String) -> UIViewController{
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: name)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let views = containerView.subviews
        print(views)
        print(containerView)
        addTargets()
        initPageViewController()
    }
    

    private func addTargets() {
        
        sectionAButton.addTarget(self, action: #selector(moveSectionA), for: .touchUpInside)
        sectionBButton.addTarget(self, action: #selector(moveSectionB), for: .touchUpInside)
    }
    
    @objc
    private func moveSectionA() {
        print(#function)
        pageViewController.setViewControllers([firstVC], direction: .reverse, animated: true, completion: nil)
    }
    
    @objc
    private func moveSectionB() {
        print(#function)
        pageViewController.setViewControllers([secondVC], direction: .forward, animated: true, completion: nil)
    }
    
    private func initPageViewController() {
        
        addChild(pageViewController)
        containerView.addSubview(pageViewController.view)
        
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageViewController.view.topAnchor.constraint(equalTo: containerView.topAnchor),
            pageViewController.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            pageViewController.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            pageViewController.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ])
        
        pageViewController.didMove(toParent: self)
        pageViewController.delegate = self
        pageViewController.dataSource = self
        
//        guard let firstVC = vcArray.first as? FirstPageVC else { return }
//        guard let secondVC = vcArray.last as? SecondPageVC else { return }
        
        
        pageViewController.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
    }

}

extension MainViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = vcArray.firstIndex(of: viewController) else { return nil }
        // 이전 페이지 인덱스
        let prevIndex = vcIndex - 1

        // 인덱스가 0 이상이라면 그냥 놔둠
        guard prevIndex >= 0 else {
            return nil

            // 무한반복 시 - 1페이지에서 마지막 페이지로 가야함
            // return vcArray.last
        }

        // 인덱스는 vcArray.count 이상이 될 수 없음
        guard vcArray.count > prevIndex else { return nil }

        print(#function, vcArray[prevIndex])
        return nil
//        return vcArray[prevIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = vcArray.firstIndex(of: viewController) else { return nil }
        

        // 다음 페이지 인덱스
        let nextIndex = vcIndex + 1

        guard nextIndex < vcArray.count else {
            return nil

            // 무한반복 시 - 마지막 페이지에서 1 페이지로 가야함
            // return vcArray.first
        }

        guard vcArray.count > nextIndex else { return nil }

        print(#function, vcArray[nextIndex])
        return nil
//        return vcArray[nextIndex]
    }
    
}
