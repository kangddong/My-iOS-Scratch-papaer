//
//  MyModel.swift
//  DeviceActivitySample
//
//  Created by 강동영 on 2023/04/20.
//

import SwiftUI
import FamilyControls
import ManagedSettings

private let _MyModel = MyModel()

class MyModel: ObservableObject {
    
    let store = ManagedSettingsStore()
    
    @Published var selectionToDiscourage: FamilyActivitySelection
    
    init() {
        selectionToDiscourage = FamilyActivitySelection()
    }
    
    class var shared: MyModel {
        return _MyModel
    }
    
    func setShieldRestrictions() {
        let applications = MyModel.shared.selectionToDiscourage
        
        store.shield.applications = applications.applicationTokens.isEmpty ? nil : applications.applicationTokens
        store.shield.applicationCategories = applications.categoryTokens.isEmpty
        ? nil
        : ShieldSettings.ActivityCategoryPolicy.specific(applications.categoryTokens)
    }
    
    func disableShieldRestrictions() {
        
        store.shield.applications = nil
        store.shield.applicationCategories = nil
    }
}
