//: [Previous](@previous)

import Foundation

func add2(_ x: Int, _ y: Int) -> Int {
    return x+y
}

add2(1,2)

func add2Currying(_ x: Int) -> ((Int) -> Int) {
    return { y in
        return x + y
    }
}

add2Currying(1)(2)
//: [Next](@next)
