//
//  Ex_String.swift
//  NSCFStringBridgeScratch
//
//  Created by 강동영 on 2023/05/07.
//

import Foundation

extension String {
    
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
