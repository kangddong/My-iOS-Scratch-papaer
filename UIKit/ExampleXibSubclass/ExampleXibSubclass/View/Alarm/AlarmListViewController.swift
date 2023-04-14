//
//  AlarmListViewController.swift
//  uTicketNew
//
//  Created by dongyeongkang on 2023/04/13.
//

import UIKit
import RxSwift

final class AlarmListViewController: UIViewController {

    @IBOutlet weak var commonNaviView: CommonNaviView!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: AlarmListViewModelAvailable?
    private var bag: DisposeBag = DisposeBag()
    
    private var alarmList: [AlarmInfo] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initLayout()
        configureTableView()
        bindViewModel()
        viewModel?.requestAlarmList(offset: 0, limit: SiksinAPI.limit)
    }
    

    private func initLayout() {
        setUpNaviView()
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        
//        let nib = UINib(nibName: CommonNotiListCell.identifier, bundle: nil)
        
//        tableView.register(CommonNotiListCell.self, forCellReuseIdentifier: CommonNotiListCell.identifier)
//        tableView.register(AlarmListCell.self, forCellReuseIdentifier: CommonNotiListCell.identifier)
        tableView.register(AlarmListCell.self, forCellReuseIdentifier: "AlarmListCell")
        
//        tableView.register(nib, forCellReuseIdentifier: CommonNotiListCell.identifier)
    }
    
    private func setUpNaviView() {
        updateHeightConstraint(view: commonNaviView)
        commonNaviView.delegate = self
        commonNaviView
            .setBackGroudColor(type: .white)
            .setTitle(title: "Alarm".localized)
            .addLeftButton(type: .backArrow)
            .build()
    }
    
    private func bindViewModel() {
        viewModel?
            .resultAlarmList
            .subscribe(onNext: { result in
                if result.isSuccess {
                    self.alarmList = result.alarmList?.notices ?? []
                    print(self.alarmList)
                } else {
                    self.view.makeToast(result.message, position: .bottom)
                }
            })
            .disposed(by: bag)
    }

}

// MARK: CommonNaviActionDelegate Method
extension AlarmListViewController: CommonNaviActionDelegate {
    func leftBackButtonAction() {
        self.dismiss(animated: false)
    }
    
    func rightBackButtonAction() {}
}
 
// MARK: UITableViewDelegate, UITableViewDataSource Method
extension AlarmListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alarmList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: CommonNotiListCell.identifier, for: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlarmListCell", for: indexPath)
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "AlarmListCell", for: indexPath)
//        let cell = tableView.dequeueReusableCell(withIdentifier: "CommonNotiListCell2", for: indexPath)
//        let cell = tableView.dequeueReusableCell(withIdentifier: "AlarmListCell2", for: indexPath)
//        guard let convertedCell = cell as? AlarmListCell2 else { return cell }
//        let item = alarmList[indexPath.row]
//        convertedCell.setData(item: item)
        
        guard let convertedCell = cell as? AlarmListCell else { return cell }
        let item = alarmList[indexPath.row]
        convertedCell.configureCell(item: item)
        
        return cell
//        return convertedCell
    }
}
