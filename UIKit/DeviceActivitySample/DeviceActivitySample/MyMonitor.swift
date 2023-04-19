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
        print(#function)
        
        let model = MyModel()
        let applicationsTokens = model.selectionToDiscourage.applicationTokens
        store.shield.applications = applicationsTokens.isEmpty ? nil : applicationsTokens
    }
    
    override func intervalDidEnd(for activity: DeviceActivityName) {
        super.intervalDidEnd(for: activity)
        print(#function)
        
        store.shield.applications = nil
    }
}
