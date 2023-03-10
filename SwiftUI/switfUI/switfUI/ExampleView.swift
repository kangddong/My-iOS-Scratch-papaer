//
//  ExampleView.swift
//  switfUI
//
//  Created by dongyeongkang on 2022/09/05.
//

import SwiftUI

struct ExampleView: View {
    var body: some View {
        NavigationView {
            
            ScrollView {
                VStack(spacing: 30) {
                    Spacer()
                    AssetMenuGridView()
                }
            }
            .background(Color.gray.opacity(0.2).edgesIgnoringSafeArea(.all))
            .navigationTitle(Text("내 자산"))
            .navigationBarTitleDisplayMode(.large)
            .navigationBarItems(trailing: Button(action: {
                //
            }, label: {
                Text("추가")
            }))
            
//            ZStack {
//                Color.gray.opacity(0.2)
//                ScrollView {
//                    VStack(spacing: 30) {
//                        Spacer()
//                        AssetMenuGridView()
//                    }
//                }
//            }
//            .navigationTitle(Text("내 자산"))
//            .navigationBarItems(trailing: Button(action: {
//                //
//            }, label: {
//                Text("추가")
//            }))
            
//            ScrollView {
//                VStack(spacing: 30) {
//                    Spacer()
//                    AssetMenuGridView()
//                }
//            }
//            .background(Color.gray.opacity(0.2).edgesIgnoringSafeArea(.all))
//            .navigationTitle(Text("내 자산"))
//            .navigationBarHidden(false)
//            .navigationBarTitleDisplayMode(.large)
//            .clipped()
//            .navigationBarItems(trailing: Button(action: {
//                //
//            }, label: {
//                Text("추가")
//            }))
        }
        .background(Color.white)
    }
}

struct ExampleView_Previews: PreviewProvider {
    static var previews: some View {
        ExampleView()
    }
}
