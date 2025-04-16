//
//  NetworkMonitor.swift
//  ExNetworkFailed
//
//  Created by 강동영 on 4/14/25.
//


import Foundation
import Network

final class NetworkMonitor {
    static let shared = NetworkMonitor()
    
    private init() {
        monitor = NWPathMonitor()
    }
    
    private let queue = DispatchQueue.global(qos: .background)
    private let monitor: NWPathMonitor
    
    func startMonitoring(statusUpdateHandler: @escaping (NWPath.Status) -> Void) {
        print("모니터링 시작")
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                statusUpdateHandler(path.status)
            }
        }
        monitor.start(queue: queue)
    }
    
    func stopMonitoring() {
        print("모니터링 중지")
        monitor.cancel()
    }
}
