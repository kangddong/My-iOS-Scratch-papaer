//
//  OnTapGestureBlinkView.swift
//  switfUI
//
//  Created by 강동영 on 2/19/24.
//

import SwiftUI

struct OnTapGestureBlinkView: View {
    @State private var isTapped = false

    var body: some View {
        Button(action: {
            isTapped.toggle()
            print("isTapped: \(isTapped)")
        }, label: {
            /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
                .frame(width: 200, height: 100)
        })
        .frame(width: 200, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .background(Color(red: 1, green: 0.9, blue: 0))
//        .scaleEffect(isTapped ? 0.9 : 1.0)
        .opacity(isTapped ? 0.3 : 1.0)
        
//        RoundedRectangle(cornerRadius: 10)
//            .foregroundColor(Color.blue)
//            .frame(width: 200, height: 100)
//            .scaleEffect(isTapped ? 0.9 : 1.0) // Scale effect when tapped
//            .opacity(isTapped ? 0 : 1.0) // Opacity effect when tapped
//            .onTapGesture {
//                withAnimation(.easeInOut(duration: 0.5)) {
//                    isTapped.toggle()
//                }
//            }
//            .onChange(of: isTapped) { oldValue, newValue in
//                print("oldValue, newValue")
//                print(oldValue, newValue)
//                if isTapped {
//                    isTapped.toggle()
//                }
//            }
    }
}

#Preview {
    OnTapGestureBlinkView()
}
