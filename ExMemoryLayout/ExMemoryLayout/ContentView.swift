//
//  ContentView.swift
//  ExMemoryLayout
//
//  Created by 강동영 on 5/20/25.
//

import SwiftUI

struct ContentView: View {
    let minPerson: PersonMin = .init()
    let maxPerson: PersonMax = .init()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            withUnsafePointer(to: self.minPerson) { ptr in
                print("minPerson", ptr)
            }
            
            withUnsafePointer(to: self.maxPerson) { ptr in
                print("minPerson", ptr)
            }
//            checkMem()
//            let person = Person()
//            print(MemoryLayout.size(ofValue: person), "onAppear")
//            print(MemoryLayout.stride(ofValue: person), "onAppear")
//            print(MemoryLayout.alignment(ofValue: person), "onAppear")
        }
    }
    private func checkMem() {
        let size = MemoryLayout<PersonMin>.size
        let stride = MemoryLayout<PersonMin>.stride
        let alignment = MemoryLayout<PersonMin>.alignment
        print("min size: \(size), stride: \(stride), alignment: \(alignment)")
        
        let size2 = MemoryLayout<PersonMax>.size
        let stride2 = MemoryLayout<PersonMax>.stride
        let alignment2 = MemoryLayout<PersonMax>.alignment
        print("max size: \(size2), stride: \(stride2), alignment: \(alignment2)")
    }
}

struct PersonMin {
    var name: String
    var age: Int
    var hasHome: Bool
    
    init(name: String = "kdy", age: Int = 30, hasHome: Bool = false) {
        self.name = name
        self.age = age
        self.hasHome = hasHome
        
//        checkMem()
    }
    
    private func checkMem() {
        
        let size = MemoryLayout<PersonMin>.size
        let stride = MemoryLayout<PersonMin>.stride
        let alignment = MemoryLayout<PersonMin>.alignment
        print("min size: \(size)")
        print("min stride: \(stride)")
        print("min alignment: \(alignment)")
    }
}

struct PersonMax {
    var age: Int
    var hasHome: Bool
    var name: String
    
    init(name: String = "kdy", age: Int = 30, hasHome: Bool = false) {
        self.name = name
        self.age = age
        self.hasHome = hasHome
        
        //        checkMem()
    }
}
#Preview {
    ContentView()
}
