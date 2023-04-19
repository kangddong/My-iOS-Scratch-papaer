//
//  MyMonitor.swift
//  DeviceActivitySample
//
//  Created by dongyeongkang on 2023/03/28.
//

import DeviceActivity

class MyMonitor: DeviceActivityMonitor {
    
    override func intervalDidStart(for activity: DeviceActivityName) {
        super.intervalDidStart(for: activity)
        print(#function)
        
    }
    
    override func intervalDidEnd(for activity: DeviceActivityName) {
        super.intervalDidEnd(for: activity)
        print(#function)
        
    }
}
