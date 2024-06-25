//
//  ContentView.swift
//  ExampleToastLibrary
//
//  Created by 강동영 on 3/27/24.
//

import SwiftUI
import PopupView

struct ContentView: View {
    @State var showingPopup = false
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            
            Button(action: {
                showingPopup.toggle()
            }, label: {
                Text("Hello, world!")
            })
        }
        .popup(isPresented: $showingPopup) {
            Text("The popup")
                .frame(width: 200, height: 60)
                .background(Color(red: 0.85, green: 0.8, blue: 0.95))
                .cornerRadius(30.0)
        } customize: {
            $0
                .position(.bottom)
                .autohideIn(2)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
