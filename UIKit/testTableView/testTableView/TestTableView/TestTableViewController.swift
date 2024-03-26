//
//  TestTableViewController.swift
//  testTableView
//
//  Created by dongyeongkang on 2022/12/26.
//

import UIKit

class TestTableViewController: UITableViewController {
    private enum Section: CaseIterable {
        case reapeatingCell
        case nestedTableView
    }
    
    let worldClassList = ["BTS", "손흥민", "봉준호", "Rx"]
    let testString = String(repeating: "안녕하세요", count: 10)
    var worldClassList2 = [String]()
    private var sections: [Section] = Section.allCases
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for _ in 0...9 {
            worldClassList2.append(testString)
        }
        tableView.register(TestTableViewCell.self, forCellReuseIdentifier: TestTableViewCell.reuseIdentifier)
        tableView.register(NestedTableViewCell.self, forCellReuseIdentifier: NestedTableViewCell.reuseIdentifier)
        tableView.separatorStyle = .none
//        tableView.separatorInset = .init(top: 16.0, left: 16, bottom: 16, right: 16)
//        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .lightGray
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch sections[section] {
        case .reapeatingCell:
            return worldClassList2.count
        case .nestedTableView:
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("=============================================")
        print("indexPath: \(indexPath)")
        print("indexPath.section: \(indexPath.section)")
        print("indexPath.row: \(indexPath.row)")
        print("indexPath.item: \(indexPath.item)")
        print("=============================================")
        
        switch sections[indexPath.section] {
        case .reapeatingCell:
            let cell = tableView.dequeueReusableCell(withIdentifier: TestTableViewCell.reuseIdentifier, for: indexPath)
            guard let convertedCell = cell as? TestTableViewCell else { return cell }
            convertedCell.setData(title: worldClassList2[indexPath.row])
            
    //        cell.textLabel?.text = worldClassList2[indexPath.row]

            return convertedCell
        case .nestedTableView:
            let cell = tableView.dequeueReusableCell(withIdentifier: NestedTableViewCell.reuseIdentifier, for: indexPath)
            guard let convertedCell = cell as? NestedTableViewCell else { return cell }
//            convertedCell.setData()
            return convertedCell
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

final class NestedTableViewCell: UITableViewCell {
    static let reuseIdentifier: String = String(describing: NestedTableViewCell.self)
    
    private let tableView: InnerTableView = {
        let tableView: InnerTableView = .init(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isScrollEnabled = false
        return tableView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview()
        addConstraints()
        configureTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    public func setData() {
        tableView.reloadData()
    }
}

extension NestedTableViewCell {
    private func addSubview() {
        contentView.addSubview(tableView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(InnerTableViewCell.self, forCellReuseIdentifier: InnerTableViewCell.reuseIdentifier)
    }
}

extension NestedTableViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: InnerTableViewCell.reuseIdentifier, for: indexPath)
        guard let convertedCell = cell as? InnerTableViewCell else { return cell }
        
        return convertedCell
    }
}
