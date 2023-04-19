//
//  ExampleView.swift
//  DeviceActivitySample
//
//  Created by dongyeongkang on 2023/03/28.
//

import SwiftUI
import FamilyControls
class MyModel: ObservableObject {
    @State var selectionToDiscourage = FamilyActivitySelection() {
        didSet {
            print(selectionToDiscourage)
        }
    }
    
}
struct ExampleView: View {
    @StateObject var model = MyModel()
    @State var isPresent: Bool = false
    @State var selection = FamilyActivitySelection()
    
    var body: some View {
        VStack {
            Button("plz select block app") { isPresent = true }
                .familyActivityPicker(isPresented: $isPresent,
                                      selection: $selection)
                .onChange(of: selection) { newSelection in
                    
                }
        }
    }
}

//struct ExampleView_Previews: PreviewProvider {
//    static var previews: some View {
//        ExampleView()
//    }
//}
