//
//  AppTabNavigation.swift
//  switfUI
//
//  Created by dongyeongkang on 2022/09/05.
//

import SwiftUI

struct AppTabNavigation: View {
    
    enum Tab {
        case asset
        case recommand
        case alert
        case setting
    }

    @State private var selection: Tab = .asset

    var body: some View {
        TabView(selection: $selection) {
            
            Color.blue
                .edgesIgnoringSafeArea(.top)
                .tabItem {
                    Image(systemName: "hand.thumbsup.fill")
                    Text("추천")
                }
                .tag(Tab.recommand)
            Color.red
                .edgesIgnoringSafeArea(.bottom)
                .tabItem {
                    Image(systemName: "bell.fill")
                    Text("알림")
                }
                .tag(Tab.alert)
            Color.yellow
                .edgesIgnoringSafeArea(.all)
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("설정")
                }
                .tag(Tab.setting)
            
            ExampleView()
                .tabItem {
                    Image(systemName: "dollarsign.circle.fill")
                    Text("자산")
                }
                .tag(Tab.asset)
            
        }
        .background(Color.red)
    }
}

struct AppTabNavigation_Previews: PreviewProvider {
    static var previews: some View {
        AppTabNavigation()
    }
}
