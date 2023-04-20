//
//  ExampleView.swift
//  DeviceActivitySample
//
//  Created by dongyeongkang on 2023/03/28.
//

import SwiftUI
import FamilyControls
import ManagedSettings

struct ExampleView: View {
    @State private var isDiscouragedPresented = false
    
    @EnvironmentObject var model: MyModel
    
    var body: some View {
        VStack {
            Button("Select Apps to Discourage") {
                isDiscouragedPresented = true
            }
            .familyActivityPicker(isPresented: $isDiscouragedPresented, selection: $model.selectionToDiscourage)
            
            Button("Select Apps to Discourage") {
                MyModel.shared.disableShieldRestrictions()
            }
        }
        .onChange(of: model.selectionToDiscourage) { newSelection in
            MyModel.shared.setShieldRestrictions()
        }
    }
}

//struct ExampleView_Previews: PreviewProvider {
//    static var previews: some View {
//        ExampleView()
//    }
//}
