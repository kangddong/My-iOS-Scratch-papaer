//
//  TestTableViewController.swift
//  testTableView
//
//  Created by dongyeongkang on 2022/12/26.
//

import UIKit

class TestTableViewController: UITableViewController {

    let worldClassList = ["BTS", "손흥민", "봉준호", "Rx"]
    let testString = String(repeating: "안녕하세요", count: 10)
    var worldClassList2 = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for _ in 0...9 {
            worldClassList2.append(testString)
        }
        tableView.register(TestTableViewCell.self, forCellReuseIdentifier: TestTableViewCell.reuseIdentifier)
        tableView.separatorStyle = .none
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
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return worldClassList2.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TestTableViewCell.reuseIdentifier, for: indexPath)
        guard let convertedCell = cell as? TestTableViewCell else { return cell }
        convertedCell.setData(title: worldClassList2[indexPath.row])
        
        print("=============================================")
        print("indexPath: \(indexPath)")
        print("indexPath.section: \(indexPath.section)")
        print("indexPath.row: \(indexPath.row)")
        print("indexPath.item: \(indexPath.item)")
        print("=============================================")
//        cell.textLabel?.text = worldClassList2[indexPath.row]

        return convertedCell
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

class TestTableViewCell: UITableViewCell {
    static let reuseIdentifier: String = "reuseIdentifier"
    
    let testLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.red.cgColor
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 16.0, left: 16, bottom: 16, right: 16))
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        print("init")
        self.contentView.addSubview(testLabel)
        
        let bottomAnchor = testLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -20)
        bottomAnchor.priority = UILayoutPriority(250)
        NSLayoutConstraint.activate([
            testLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20),
            testLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            testLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),
            bottomAnchor,
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setData(title: String) {
        testLabel.text = title
    }
}
