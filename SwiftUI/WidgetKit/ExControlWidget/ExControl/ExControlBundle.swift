//
//  ExControlBundle.swift
//  ExControl
//
//  Created by 강동영 on 6/13/24.
//

import WidgetKit
import SwiftUI

@main
struct ExControlBundle: WidgetBundle {
    var body: some Widget {
        ExControl()
        ExControlLiveActivity()
        if #available(iOSApplicationExtension 18.0, *) {
            ExControlControl()
        }
//        if #available(iOSApplicationExtension 18.0, *) {
//            return WidgetBundleBuilder.buildBlock(ExControl(), ExControlLiveActivity())
//        } else {
//            return WidgetBundleBuilder.buildBlock(ExControl(), ExControlLiveActivity())
//        }
    }
}
