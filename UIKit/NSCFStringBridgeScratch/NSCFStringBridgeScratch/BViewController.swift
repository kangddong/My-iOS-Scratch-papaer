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
        "Notices".localized,
        "Events".localized,
        "Helps".localized,
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc: UIViewController = NoticesViewController()
        let convertedString: NSString = NSString(string: tableViewDataSource[indexPath.row])
        NoticesViewController().setLocalizedTitle(convertedString as String)
        
        self.present(vc, animated: true)
    }
}
