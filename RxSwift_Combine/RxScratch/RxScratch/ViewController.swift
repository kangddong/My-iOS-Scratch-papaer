//
//  ViewController.swift
//  RxScratch
//
//  Created by dongyeongkang on 2023/08/04.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let obserable1 = Observable.just(1)
        obserable1.subscribe { event in // Event<Int>
            print(event)
        }
        

        let obserable2 = Observable.of(1, 2, 3)
        obserable2.subscribe { event in // Event<Int>
            print(event)
        }
        
        let obserable3 = Observable.of([1, 2, 3])
        obserable3.subscribe { event in // Event<Int>
            print(event)
        }
    }
}

