//
//  ContentView.swift
//  ExNaviSwipeGesture
//
//  Created by 강동영 on 4/25/25.
//

import SwiftUI

struct ContentView: View {
    @State private var isButtonViewPresented = false
    
    var body: some View {
        VStack {
            NavigationStack {
                CustomNavigationBar(title: "Main") {
                    
                }
                Spacer()
                // 1. NavigationLink 방식
                NavigationLink("NavigationLink") {
                    AView()
                }
                
                // 2. navigationDestination(for:destination:) modifier 방식
                Button("Button") {
                    isButtonViewPresented.toggle()
                }
                .navigationDestination(isPresented: $isButtonViewPresented) {
                    BView()
                }
            }
        }
        
    }
}

#Preview {
    ContentView()
}

struct AView: View {
    var body: some View {
        VStack {
            CustomNavigationBar(title: "A") {
                
            }
            Spacer()
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(0..<20) { i in
                        Text("Item \(i)")
                            .frame(width: 150, height: 150)
                            .background(Color.gray)
                            .cornerRadius(8)
                            .padding()
                    }
                }
            }
        }
        .navigationBarBackButtonHidden()
        
    }
}

struct BView: View {
    @State private var showPopover = false
    
    var body: some View {
        VStack {
            CustomNavigationBar(title: "A") {}
            Spacer()
            
            Button("Show Popover") {
                showPopover.toggle()
            }
            .popover(isPresented: $showPopover) {
                Text("Popover Content")
                    .frame(width: 200, height: 200)
            }
            // ✅ frame 영역을 기반으로 인식기가 동작하기 때문에 edge 영역에 padding 주기
            ScrollView(.horizontal) {
                HStack {
                    ForEach(0..<10) { _ in
                        Text("Hello")
                            .padding()
                            .background(Color.blue)
                    }
                }
            }
            .padding(.horizontal, 10)
            
            Spacer()
        }
        .navigationBarBackButtonHidden()
    }
}

import UIKit

extension UINavigationController: @retroactive UIGestureRecognizerDelegate {
    open override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
    
    // ✅ 제스처 충돌자체를 허용하기
//    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//        true
//    }
}
