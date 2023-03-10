//
//  BluetoothManager.swift
//  BeaconSampleApp
//
//  Created by dongyeongkang on 2023/02/24.
//

import UIKit
import CoreBluetooth

var serial : BluetoothManager!

protocol BluetoothManagerDelegate : AnyObject {
    func serialDidDiscoverPeripheral(peripheral : CBPeripheral, RSSI : NSNumber?)
    func serialDidProcess()
}

extension BluetoothManagerDelegate {
    func serialDidDiscoverPeripheral(peripheral : CBPeripheral, RSSI : NSNumber?) {}
}


class BluetoothManager: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate {
     
    typealias BLEInfo = (peripheral: CBPeripheral, RSSI: Double)
    
    var delegate : BluetoothManagerDelegate?
    var centralManager : CBCentralManager!
    var serviceUUID = CBUUID(string: "FFF1")
    var deviceName = "MBeacon"
    private var beaconDictionary: Dictionary<String,BLEInfo> = [:]
    private var addressList: [String] = [] {
        didSet {
            delegate?.serialDidProcess()
        }
    }
    
    //MARK: 함수
    
    /// serial을 초기화할 떄 호출하여야합니다. 시리얼은 nil될 수 없기 때문에 항상 초기화후 사용해야 합니다.
    override init() {
        super.init()
        self.centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    /// 기기 검색을 시작합니다. 연결이 가능한 모든 주변기기를 serviceUUID를 통해 찾아냅니다.
    func startScan() {
        guard centralManager.state == .poweredOn else { return }
        
        // CBCentralManager의 메서드인 scanForPeripherals를 호출하여 연결가능한 기기들을 검색합니다. 이 떄 withService 파라미터에 nil을 입력하면 모든 종류의 기기가 검색되고, 지금과 같이 serviceUUID를 입력하면 특정 serviceUUID를 가진 기기만을 검색합니다.
        // withService의 파라미터를 nil로 설정하면 검색 가능한 모든 기기를 검색합니다.
        // 새로운 주변기기가 연결될 때마다 centralManager(_:didDiscover:advertisementData:rssi:)를 호출합니다.
        //centralManager.scanForPeripherals(withServices: [serviceUUID], options: nil)
        print("serviceUUID = \(serviceUUID)")
        centralManager.scanForPeripherals(withServices: nil, options: nil)
        
        // 이미 연결된 기기들을 peripherals 변수에 반환받는 과정입니다.
        let peripherals = centralManager.retrieveConnectedPeripherals(withServices: [serviceUUID])
//        for peripheral in peripherals {
//            // 연결된 기기들에 대한 처리를 코드로 작성합니다.
//            delegate?.serialDidDiscoverPeripheral(peripheral: peripheral, RSSI: nil)
//        }
    }
    
    /// 기기 검색을 중단합니다.
    func stopScan() {
        centralManager.stopScan()
    }
    
    /// rssi 신호를 거리로 변환하는 함수
    /// - Parameter rssi: rssi signal
    /// - Returns: return Double value
    private func rssiToDistance(rssi: Float) -> Double {
        let n: Double = 2.0
        let alpha: Double = -63.0
        
        let distance = pow(10.0, ((alpha - Double(rssi)) / (10.0 * n)))
        return round((distance * 100.0)) / 100.0 // 소수점 두자리만 남겨놓고 나머지 버림.
    }
    
    //MARK: Central, Peripheral Delegate 함수
    
    // CBCentralManagerDelegate에 포함되어 있는 메서드입니다. central 기기의 블루투스 상태가 변경될 때마다 호출됩니다. centralManager.state의 값은 켜져있을 때 .poweredOn, 꺼져있을 때 .poweredOff로 변경됩니다.
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
    
    // 기기가 검색될 때마다 호출되는 메서드입니다.
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        guard let name = peripheral.name, name == deviceName,
              let strAddress = takeMacAddress(data: advertisementData)
        else { return }
            
        beaconDictionary.updateValue((peripheral: peripheral, RSSI: RSSI.doubleValue), forKey: strAddress)
        addressList = beaconDictionary.keys.map { String($0) }
        peripheralLog(peripheral, RSSI)
        // 기기가 검색될 때마다 필요한 코드를 여기에 작성합니다.
        // RSSI는 기기의 신호 강도를 의미합니다.
        delegate?.serialDidDiscoverPeripheral(peripheral: peripheral, RSSI: RSSI)
    }
    
    private func peripheralLog(_ peripheral: CBPeripheral, _ RSSI: NSNumber) {
        print(#function)
        print("============MBeacon===============")
        print("name = \(peripheral.name)")
        print("identifier = \(peripheral.identifier)")
        print("RSSI = \(RSSI)")
        print("===============MBeacon============")
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
}
