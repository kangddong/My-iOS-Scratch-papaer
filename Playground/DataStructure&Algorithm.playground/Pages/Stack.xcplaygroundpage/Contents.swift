//: [Previous](@previous)

import Foundation

struct Stack<T> {
    private var stack: [T] = []
    
    public var count: Int {
        return stack.count
    }
    
    public var isEmpty: Bool {
        return stack.isEmpty
    }
    
    public mutating func push(_ element: T) {
        stack.append(element)
    }
    
    public mutating func pop() -> T? {
        return isEmpty ? nil : stack.popLast()
    }
}

var myStack = Stack<Int>()
myStack.push(10)
myStack.pop()

//: [Next](@next)



hot
tid
storyContents
score

likeCnt
likeYn

writeUser
photo
"place": {
    "pid": 28566,
    "pname": "정식당",
    "upHpAreaTitle": null,
    "hpAreaTitle": null,
    "hpSchCateNm": null
},
commentCnt
writeDt
tag
