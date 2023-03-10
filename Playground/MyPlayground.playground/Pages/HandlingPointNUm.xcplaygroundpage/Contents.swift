import Foundation

var decimalPoints: [Double] = [30.6, 2.4, -1.2, -1.6]

/*
 ceil 올림
 floor 내림
 trunc 버림
 round 반올림
 abs 절대값
 fabs Double 형의 절대값
 */

func testDecimal() {
    
    print(#function + "start \n")
    decimalPoints.forEach { number in
        print("origin \(number)")
        print("ceil = \(ceil(number))")
        print("floor = \(floor(number))")
        print("trunc = \(trunc(number))")
        print("round = \(round(number))")
        print("abs = \(abs(number))")
        print("fabs = \(fabs(number))")
        print("\n")
    }
}

testDecimal()
