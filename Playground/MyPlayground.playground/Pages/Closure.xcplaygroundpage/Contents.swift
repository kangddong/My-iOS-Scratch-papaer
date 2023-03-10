//: [Previous](@previous)

import Foundation

func abc(query: String) {
    
    fetch(query: query) {
        print("abc함수   ")
    }
}

func fetch(query: String, completion: (() -> ())?) {
    print("fetch 함수")
    //completion()
}

abc(query: "a")
//fetch(query: "a", completion: <#T##() -> ()#>)
//: [Next](@next)
