//
//  ButtonTouchEventView.swift
//  switfUI
//
//  Created by 강동영 on 2/19/24.
//

import SwiftUI

struct ButtonTouchEventView: View {
    @State private var isTapped = false

    var body: some View {
//        Button(action: {
////            isTapped.toggle()
////            print("isTapped: \(isTapped)")
//        }, label: {
//            /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
//                .frame(width: 200, height: 100)
//                
//                .onTouchDownUp { pressed in
//                    print("isTapped: \(isTapped)")
//                    self.isTapped = pressed
//                }
//                .opacity(isTapped ? 0.3 : 1.0)
////                .scaleEffect(isTapped ? 0.9 : 1.0)
//                
//        })
//        .frame(width: 200, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//        .background(Color(red: 1, green: 0.9, blue: 0))
//        .animation(.spring(), value: isTapped)
        
        Button(action: {}, label: {
            ZStack {
                RoundedRectangle(cornerRadius: 5)
                    .foregroundStyle(.yellow)
                HStack {
                    Image(systemName: "apple.logo")
                    Text("애플 로그인")
                }
            }
            .foregroundStyle(.black)
        })
        .frame(height: 50)
        
    }
}

extension View {
    func onTouchDownUp(pressed: @escaping ((Bool) -> Void)) -> some View {
        self.modifier(TouchDownUpEventModifier(pressed: pressed))
    }
}

struct TouchDownUpEventModifier: ViewModifier {
    @State var dragged = false
    
    var pressed: (Bool) -> Void
    func body(content: Content) -> some View {
        content
            .gesture(DragGesture(minimumDistance: 0)
                .onChanged { _ in
                    if !dragged {
                        dragged = true
                        pressed(true)
                    }
                }
                .onEnded { _ in
                    dragged = false
                    pressed(false)
                }
            )
        
    }
    
}
#Preview {
    ButtonTouchEventView()
}
