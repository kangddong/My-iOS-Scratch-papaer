//
//  ContentView.swift
//  TestNavigation
//
//  Created by 강동영 on 3/18/24.
//

import SwiftUI

enum ViewType {
    case A
    case B
    case C
}
struct ContentView: View {
    @State var paths: [ViewType] = []
    var body: some View {
        NavigationStack(path: $paths) {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, world!")
            }
            .padding()
            Button(action: { paths.append(.A)}, label: {
                Text("push A")
            })
            Button(action: { paths.append(.B)}, label: {
                Text("push B")
            })
            Button(action: { paths.append(.C)}, label: {
                Text("push C")
            })
        }

    }
}

#Preview {
    ContentView()
}
