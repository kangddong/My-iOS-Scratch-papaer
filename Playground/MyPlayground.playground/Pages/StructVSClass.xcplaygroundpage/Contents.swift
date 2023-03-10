//: [Previous](@previous)

import Foundation
import Darwin

class Person {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

var person1 = Person(name: "Rx")
var person2 = person1

person1.name = "Combine" // person2.name 또한 Combine으로 변경

struct Car {
    var name: String
}

var car1 = Car(name: "Sonata")
var car2 = car1

car1.name = "Avante" // car2.name은 Sonata

enum Coffee {
    case americano
    case espresso
}

var coffee1 = Coffee.americano
var coffee2 = coffee1

coffee1 = .espresso
coffee2

func addOne(value: inout Int) {
    value += 1
    print(value)
}

var number = 1
addOne(value: &number)
number

var swapA = 20
var swapB = 30

func swapValue(a: inout Int, b: inout Int) {
    print("Before Swap a: \(a), b: \(b)")
    let temp = a
    a = b
    b = temp
    print("After Swap a: \(a), b: \(b)")
}


swapValue(a: &swapA, b: &swapB)
person1
swapA
swapB
MemoryLayout<Person>.size
//: [Next](@next)

