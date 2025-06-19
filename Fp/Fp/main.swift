//
//  main.swift
//  Fp
//
//  Created by 강동영 on 4/22/25.
//

import Foundation

//let answer = Int(arc4random() % 100) + 1
//let answer = 50
//var count = 0

func nonFP() {
    var count = 0
    let answer = 50
    while true {

        let userInput = readLine()
//        let userInput = [50, 40, 30, 35, 33, 31, 32]

        guard let unwrappedInput = userInput, let inputNumber = Int(unwrappedInput) else {
            print("Wrong")
            continue
        }

        if inputNumber == answer {
            print("Correct! : \(count)")
            break
        }

        if inputNumber > answer {
            print("High")
        }

        if inputNumber < answer {
            print("Low")
        }

        count += 1
    }
}

enum Result: String {
    case wrong = "Wrong"
    case correct = "Correct!"
    case high = "High"
    case low = "Low"
}

func generateAnswer(_ min: Int, _ max: Int) -> Int {
    return Int(arc4random()) % (max - min) + min
}
func inputAndCheck(_ answer: Int) -> () -> Bool {
//    let userInput = readLine()
//    
//    guard let unwrappedInput = userInput, let inputNumber = Int(unwrappedInput) else {
//        print("Wrong")
//        return true
//    }
//
//    if inputNumber == answer {
//        return false
//    }
//
//    if inputNumber > answer {
//        print("High")
//    }
//
//    if inputNumber < answer {
//        print("Low")
//    }
//    return true
    return { printResult(evaluateInput(answer)) }
}

func evaluateInput(_ answer: Int) -> Result {
    guard let inputNumber = Int(readLine() ?? "") else { return .wrong }
    if inputNumber > answer { return .high }
    if inputNumber < answer { return .low }
    return .correct
}

func printResult(_ r: Result) -> Bool {
    if case .correct = r { return false }
    print(r.rawValue)
    return true
}
func corrected(_ count: Int) {
    print("Correct! : \(count)")
}
func countingLoop(_ needContinue: () -> Bool, _ finished: (Int) -> Void) {
// 그때 당시에는 error가 나왔음 escaping 을 왜 해야하지
// Declaration closing over non-escaping parameter 'needContinue' may allow it to escape
//func countingLoop(_ needContinue: @escaping () -> Bool) {
    
    // 2. 재귀로 변경
    func counter(_ c: Int) -> Int {
        if !needContinue() { return c }
        return counter(c + 1)
    }
//    var count = 0
//    while true {
//        if needContinue() { break }
//        count += 1
//    }
    // 1. Correct 출력 위치 변경
    finished(counter(0))
}

func fp() {
    countingLoop(inputAndCheck(generateAnswer(1, 100)), corrected)
    // 프로그램이 수행하는 과정을 프로그래밍하는게 아닌 어떠한 동작을 해야하고, 결과가 나와야하는지 정의하는 것을 선언형 프로그램이라고한다
}
fp()

//: [Next](@next)


