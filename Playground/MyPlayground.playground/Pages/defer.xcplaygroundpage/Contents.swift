//: [Previous](@previous)

import Foundation

enum CastingError: Error {
    case string
}
func testDefer(number: String) throws -> Int {
    
    defer {
        print("defer first")
    }
    
    print("return \(Int(number)!)")
    
    defer {
        print("defer second")
    }
    
    if Int(number) == nil {
        throw CastingError.string
    } else {
        
        defer {
            print("defer third")
        }
        
        return Int(number)!
    }
    
    
    
}

try testDefer(number: "1")
//: [Next](@next)
