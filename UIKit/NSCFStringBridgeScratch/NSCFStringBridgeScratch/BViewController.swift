//
//  BViewController.swift
//  NSCFStringBridgeScratch
//
//  Created by dongyeongkang on 2023/05/03.
//

import UIKit

class BViewController: UIViewController {

    private let identifier: String = "cell"
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    private var tableViewDataSource: [String] = [
        "테스트 A",
        "테스트 B"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension BViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        
        let cellTitle = tableViewDataSource[indexPath.row]
        
        let textLabel = cell.contentView.viewWithTag(1) as? UILabel
        textLabel?.text = cellTitle
        
        return cell
    }
}
