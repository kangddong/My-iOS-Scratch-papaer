//
//  ExampleView.swift
//  DeviceActivitySample
//
//  Created by dongyeongkang on 2023/03/28.
//

import SwiftUI
import FamilyControls

struct ExampleView: View {
    @State var selection = FamilyActivitySelection()

    var body: some View {
            VStack {
                FamilyActivityPicker(selection: $selection)
            }
            .onChange(of: selection) { newSelection in
                let applications = selection.applications
                let categories = selection.categories
                let webDomains = selection.webDomains
            }
        }
}

//struct ExampleView_Previews: PreviewProvider {
//    static var previews: some View {
//        ExampleView()
//    }
//}
