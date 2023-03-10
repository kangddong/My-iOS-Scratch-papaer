//
//  ViewController.swift
//  CoreDataPractice
//
//  Created by dongyeongkang on 2022/08/30.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    var container: NSPersistentContainer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard container != nil else {
            fatalError("This view needs a persistent container.")
        }
    }


}

