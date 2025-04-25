//
//  CustomNavigationBar.swift
//  ExNaviSwipeGesture
//
//  Created by 강동영 on 4/25/25.
//

import SwiftUI

struct CustomNavigationBar: View {
    
    let title: String
    let backButtonAction: () -> Void
    
    var body: some View {
        HStack {
            Button {
                backButtonAction()
            } label: {
                Image(systemName: "chevron.left")
                    .font(.system(size: 24, weight: .bold))
            }
            
            Spacer()
            
            Text(title)
                .font(.system(size: 17, weight: .semibold))
            
            Spacer()
            
            Text("🥰")
        }
        .frame(height: 56)
	.padding(.horizontal, 16)
	.foregroundStyle(.white)
	.background(.black)
    }
}
