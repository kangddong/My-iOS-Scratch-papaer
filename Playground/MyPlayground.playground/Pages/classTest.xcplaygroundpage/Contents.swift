//: [Previous](@previous)

import Foundation

/*
 유연성 : flexibility
 의존성 : dependency
 
 기존 변수와 상수 -> Properties in Class or Struct
 Function (함수) -> Method in Class or Struct
 
 Properties + Method -> Meber in Class or Struct

 */


struct Resolution {
    var width = 0
    var height = 0
    
    func desc() -> String {
        return "Resolution 구조체"
    }
}

class VideoMode {
    var interlaced = false
    var frameRate = 0.0
    var name: String?
    
    func desc() -> String {
        return "VideoMode 구조체"
    }
}

let structA = Resolution()
let structB = VideoMode()
structA.desc()
structB.desc()
