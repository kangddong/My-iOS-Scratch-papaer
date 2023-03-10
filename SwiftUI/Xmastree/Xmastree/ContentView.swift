//
//  ContentView.swift
//  Xmastree
//
//  Created by dongyeongkang on 2022/12/29.
//

import SwiftUI

struct Rings: Hashable, Identifiable {
    let id: CGFloat
    let color: Color
    let setY: CGFloat
}

struct ContentView: View {
    
    @State private var isSpinning = false
    var rings: [Rings] = [Rings(id: 1, color: Color.yellow, setY: 10),
                          Rings(id: 2, color: Color.orange, setY: 15),
                          Rings(id: 3, color: Color.orange, setY: 20),
                          Rings(id: 4, color: Color.red, setY: 25),
                          Rings(id: 5, color: Color.red, setY: 30),
                          Rings(id: 6, color: Color.purple, setY: 35),
                          Rings(id: 7, color: Color.blue, setY: 40),
                          Rings(id: 8, color: Color.cyan, setY: 45),
                          Rings(id: 9, color: Color.cyan, setY: 50),
                          Rings(id: 10, color: Color.green, setY: 55),]
    var radius: CGFloat = 40
    var yPosition: CGFloat = 100
    
    var body: some View {
        VStack {
            Image(systemName: "wand.and.stars.inverse")
                .font(.system(size: 64))
                .foregroundStyle(EllipticalGradient(
                    colors: [Color.red, Color.green],
                    center: .center,
                    startRadiusFraction: 0.0,
                    endRadiusFraction: 0.5))
                .hueRotation(.degrees(isSpinning ? 0 : 340))
                .animation(.linear(duration: 1).repeatForever(autoreverses: false).delay(0.2),
                           value: isSpinning)
                .offset(x: 0, y: 100)
                
            ZStack {
                ForEach(rings, id: \.self.id) { ring in
                    ZStack {
                        Circle()
                            .stroke(ring.color, lineWidth: 10)
                            .frame(width: radius * (ring.id / 2), height: radius * (ring.id / 2))
                            .position(x: 200, y: (yPosition * ring.id/2))
                        
                        Image(systemName: "star.fill")
                            .font(.system(size: 20))
                            .foregroundStyle(Color.yellow)
                            .hueRotation(.degrees(isSpinning ? 0 : 340))
                            .offset(x: (radius * (ring.id / 2) / 2), y: 0)
                            .rotation3DEffect(Angle.degrees(isSpinning ? 360 : 0), axis: (x: 0, y: 0, z: 1))
                            .position(x: 200, y: (yPosition * ring.id/2))
                            .animation(.linear(duration: 1).repeatForever(autoreverses: false).delay(0).speed(0.5), value: isSpinning)
                    }
                    .rotation3DEffect(Angle.degrees(55), axis: (x: 1, y: 0, z: 0))
                    .offset(x: 0, y: ring.setY)
                    //.offset(x: 0, y: 300)

                }
            }
            .onAppear() {
                isSpinning.toggle()
            }
        }.background(Color.black)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
