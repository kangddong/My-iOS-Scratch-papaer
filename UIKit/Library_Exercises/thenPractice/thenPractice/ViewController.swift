//
//  ViewController.swift
//  thenPractice
//
//  Created by dongyeongkang on 2022/12/09.
//

import UIKit

struct Dummy {
    var title: String
    var subtitle: String
    var content: String
}

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    
    var dummyList: [Dummy] = [Dummy(title: "1 2줄 이상 멀티라인 확인 용",
                                    subtitle: "2 2줄 이상 멀티라인 확인 용",
                                    content: "3 2줄 이상 멀티라인 확인 용"),
                              Dummy(title: "2줄 이상 멀티라인 확인 용2줄 이상 ",
                                    subtitle: "2 2줄 이상 멀티라인 확인 용 2 2줄 이상 멀티라인 확인 용 2 2줄 이상 멀티라인 확인 용 2 2줄 이상 멀티라인 확인 용 2 2줄 이상 멀티라인 확인 용 2 2줄 이상 멀티라인 확인 용 2 2줄 이상 멀티라인 확인 용",
                                    content: "3 2줄 이상 멀티라인 확인 용"),
                              Dummy(title: "2줄 이상 멀티라인 확인 용2줄 이상 멀티라인 확인 용2줄 이상 멀티라인 확인 용2줄 이상 멀티라인 확인 용2줄 이상 멀티라인 확인 용",
                                    subtitle: "2 2줄 이상 멀티라인 확인 용 2 2줄 이상 멀티라인 확인 용 2 2줄 이상 멀티라인 확인 용 2 2줄 이상 멀티라인 확인 용 2 2줄 이상 멀티라인 확인 용 ",
                                    content: "3 2줄 이상 멀티라인 확인 용 3 2줄 이상 멀티라인 확인 용 3 2줄 이상 멀티라인 확인 용 3 2줄 이상 멀티라인 확인 용 3 2줄 이상 멀티라인 확인 용 3 2줄 이상 멀티라인 확인 용 3 2줄 이상 멀티라인 확인 용"),
                              Dummy(title: "2줄 이상 멀티라인 확인 용2줄 이상 멀티라인 확인 용2줄 이상 멀티라인 확인 용2줄 이상 멀티라인 확인 용2줄 이상 멀티라인 확인 용",
                                    subtitle: "2 2줄 이상 멀티라인 확인 용",
                                    content: "3 2줄 이상 멀티라인 확인 용"),
                              Dummy(title: "2줄 이상 멀티라인 확인 용2줄 이상 멀티라인 확인 용2줄 이상 멀티라인 확인 용2줄 이상 멀티라인 확인 용2줄 이상 멀티라인 확인 용",
                                    subtitle: "2 2줄 이상 멀티라인 확인 용",
                                    content: "3 2줄 이상 멀티라인 확인 용"),
                              Dummy(title: "2줄 이상 멀티라인 확인 용2줄 이상 멀티라인 확인 용2줄 이상 멀티라인 확인 용2줄 이상 멀티라인 확인 용2줄 이상 멀티라인 확인 용",
                                    subtitle: "2 2줄 이상 멀티라인 확인 용",
                                    content: "3 2줄 이상 멀티라인 확인 용"),
                              Dummy(title: "2줄 이상 멀티라인 확인 용2줄 이상 멀티라인 확인 용2줄 이상 멀티라인 확인 용2줄 이상 멀티라인 확인 용2줄 이상 멀티라인 확인 용",
                                    subtitle: "2 2줄 이상 멀티라인 확인 용",
                                    content: "3 2줄 이상 멀티라인 확인 용"),
                              Dummy(title: "2줄 이상 멀티라인 확인 용2줄 이상 멀티라인 확인 용2줄 이상 멀티라인 확인 용2줄 이상 멀티라인 확인 용2줄 이상 멀티라인 확인 용",
                                    subtitle: "2 2줄 이상 멀티라인 확인 용",
                                    content: "3 2줄 이상 멀티라인 확인 용"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tableView.delegate = self
        //tableView.dataSource = self
        //tableView.rowHeight = UITableView.automaticDimension
    }

    func configureTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TestCell", for: indexPath)
        
        guard let convertedCell = cell as? TestCell else { return cell }
        let item = dummyList[indexPath.row]
        
        convertedCell.configureCell(item: item)
        return convertedCell
    }
    
    
}

class TestCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var content: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(item: Dummy) {
        
        title.text = item.title
        subTitle.text = item.subtitle
        content.text = item.content
    }
}

