//
//  DynamicIslandPracticeBundle.swift
//  DynamicIslandPractice
//
//  Created by dongyeongkang on 2022/11/25.
//

import WidgetKit
import SwiftUI

@main
struct DynamicIslandPracticeBundle: WidgetBundle {
    var body: some Widget {
        DynamicIslandPractice()
        if #available(iOS 16.1, *) {
            DynamicIslandPracticeLiveActivity()
        }
    }
}
