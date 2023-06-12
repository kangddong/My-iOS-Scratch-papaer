//
//  PageViewController.swift
//  uipageVCTest
//
//  Created by dongyeongkang on 2022/09/07.
//

import UIKit

class PageViewController: UIPageViewController {

    lazy var vcArray: [UIViewController] = {
        return [self.vcInstance(name: "FirstPageVC"),
                self.vcInstance(name: "SecondPageVC"),
                self.vcInstance(name: "ThirdPageVC")]
    }()
    
    private func vcInstance(name: String) -> UIViewController{
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: name)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        self.delegate = self
        // 첫 번째 페이지를 기본 페이지로 설정
        if let firstVC = vcArray.first {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //setViewControllers(<#T##viewControllers: [UIViewController]?##[UIViewController]?#>, direction: .forward, animated: true)
    }

}

extension PageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
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
