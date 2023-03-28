//
//  MyMonitor.swift
//  DeviceActivitySample
//
//  Created by dongyeongkang on 2023/03/28.
//

import DeviceActivity
import ManagedSettings



class MyMonitor: DeviceActivityMonitor {
    let store = ManagedSettingsStore()
    
    override func intervalDidStart(for activity: DeviceActivityName) {
        super.intervalDidStart(for: activity)
//        let applications

//        store.shield.applications = applications.isEmpty ? nil : applications
//        let model = MyModel()
//        let applications =
    }
    
    override func intervalDidEnd(for activity: DeviceActivityName) {
        super.intervalDidEnd(for: activity)
        
        store.shield.applications = nil
    }
}
