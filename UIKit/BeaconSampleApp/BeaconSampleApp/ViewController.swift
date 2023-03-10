//
//  ViewController.swift
//  BeaconSampleApp
//
//  Created by dongyeongkang on 2023/02/24.
//

import UIKit
import CoreBluetooth

class ViewController: UIViewController {

    typealias BLEInfo = (peripheral: CBPeripheral, RSSI: Double)
    
    let headerImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "headerImage")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let storeNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "엄브렐라(라쿤시티) 연구동 구내식당"
        label.textAlignment = .left
        label.textColor = .white
        label.sizeToFit()
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.register(UINib(nibName: BeaconListCell.identifier, bundle: nil),
                           forCellReuseIdentifier: BeaconListCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white

        return tableView
    }()
    
    lazy var emptyLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Can't find anything"
        label.textAlignment = .center
        label.textColor = .label
        label.font = UIFont.boldSystemFont(ofSize: 20)
        
        return label
    }()
    
    private var startDate: Date =  Date()
    
    private var beaconDictionary: Dictionary<String,BLEInfo> = [:]
    private var addressList: [String] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    
    private var centralManager: CBCentralManager!
    private var serviceUUID = CBUUID(string: "FFF1")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initNavigationItem()
        initViews()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        startScan()
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 10.0, execute: { [weak self] in
            self?.stopScan()
        })
    }
    
    private func initNavigationItem() {
        let leftBarButton = UIBarButtonItem(title: "Stop",
                                            style: .plain,
                                            target: self,
                                            action: #selector(stopScan))
        let rightBarButton = UIBarButtonItem(title: "Scan",
                                            style: .plain,
                                            target: self,
                                            action: #selector(startScan))

        navigationItem.title = "비콘 결제"
        navigationItem.setRightBarButton(rightBarButton, animated: true)
        navigationItem.setLeftBarButton(leftBarButton, animated: true)
    }
    
    private func initViews() {
        view.addSubview(headerImageView)
        view.addSubview(storeNameLabel)
        view.addSubview(tableView)
        view.addSubview(emptyLabel)
        
        setConstraints()
    }
    
    private func setConstraints() {
        headerImageView.translatesAutoresizingMaskIntoConstraints = false
        storeNameLabel.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        emptyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerImageView.topAnchor.constraint(equalTo: view.topAnchor),
            headerImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerImageView.heightAnchor.constraint(equalToConstant: 300),
            storeNameLabel.leadingAnchor.constraint(equalTo: headerImageView.leadingAnchor),
            storeNameLabel.bottomAnchor.constraint(equalTo: headerImageView.bottomAnchor),
            
            tableView.topAnchor.constraint(equalTo: headerImageView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            emptyLabel.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
            emptyLabel.centerYAnchor.constraint(equalTo: tableView.centerYAnchor),
        ])
    }
    
    @objc
    private func startScan() {
        guard centralManager.isScanning == false else { return }
        startDate = Date()
        centralManager.scanForPeripherals(withServices: [serviceUUID], options: [CBCentralManagerScanOptionAllowDuplicatesKey : true])
        
    }
    
    @objc
    private func stopScan() {
        centralManager.stopScan()
    }


}

// MARK: UITableViewDelegate, UITableViewDataSource Method
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        emptyLabel.isHidden = beaconDictionary.count == 0 ? false : true
        
        return beaconDictionary.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BeaconListCell.identifier, for: indexPath)
        guard let convertedCell = cell as? BeaconListCell else { return cell }
        
        let key = addressList[indexPath.row]
        guard let item = beaconDictionary[key] else { return cell }
        convertedCell.setData(name: item.peripheral.name,
                              RSSI: item.RSSI,
                              macAddress: key,
                              now: startDate)
        return convertedCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let key = addressList[indexPath.row]
        
        var toastMessage: String?
        switch key {
        case "AC:23:3F:F6:B4:AF":
            toastMessage = "특식"
        case "AC:23:3F:F6:B4:B1":
            toastMessage = "분식"
        case "AC:23:3F:F6:B4:A8":
            toastMessage = "일반"
        default:
            toastMessage = key
            
        }
        
        guard let toastMessage = toastMessage else { return }
        
        let alert = UIAlertController(title: "결제", message: "\(toastMessage) 결제되었습니다.", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "확인", style: .default)
        alert.addAction(confirmAction)
        
        present(alert, animated: true)
    }
}

extension ViewController: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        print(#function)
        switch central.state {
            
        case .unknown:
            print("unknown")
        case .resetting:
            print("resetting")
        case .unsupported:
            print("unsupported")
        case .unauthorized:
            print("unauthorized")
        case .poweredOff:
            print("poweredOff")
        case .poweredOn:
            print("poweredOn")
        @unknown default:
            print("default")
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        guard let name = peripheral.name, name == "MBeacon",
              let strAddress = takeMacAddress(data: advertisementData)
        else { return }
        
        beaconDictionary.updateValue((peripheral: peripheral, RSSI: RSSI.doubleValue), forKey: strAddress)
        // FIXME: SORT value -> Array BLEInfo 주소, name is menu name
        
        addressList = beaconDictionary.keys.map { String($0) }
        peripheralLog(peripheral, RSSI)
        
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print(#function)
        
        print("peripheral = \(peripheral)")
    }
    
    private func takeMacAddress(data: [String : Any]) -> String? {
        guard let dic = data["kCBAdvDataServiceData"] as? Dictionary<CBUUID, Data>,
              let data = dic[serviceUUID],
              data.count == 11 else { return nil }
        
        let macAddress = data[5...10]
        let strAddress = macAddress.map({ String(format:"%02x ", $0) })
            .joined()
            .uppercased()
            .trimmingCharacters(in: .whitespaces)
            .replacingOccurrences(of: " ", with: ":")
        
        return strAddress
    }
    
    private func peripheralLog(_ peripheral: CBPeripheral, _ RSSI: NSNumber) {
        print(#function)
        print("============MBeacon===============")
        print("name = \(peripheral.name)")
        print("identifier = \(peripheral.identifier)")
        print("RSSI = \(RSSI)")
        print("===============MBeacon============")
    }
}
