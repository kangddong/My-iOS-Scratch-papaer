import Foundation

// MARK: map
// 각 요소에 대한 값을 변경하고자 할 때 사용하고, 그 결과들을 배열로 반환합니다.
let names = ["BTS", "손흥민", "봉준호", "Rx",]
names.map {
    $0 + "'s name"
}

let array = [1, 2, 3, 4, 5]
let mapTest1 = array.map { $0 + 1 }

print(" =================================================== ")
print("map, flatMap, compactMap\n")
print("mapTest1 \(mapTest1)")

// MARK: 1차원 배열의 경우
let array1 = [1, nil, 3, nil, 5, 6, 7]

// MARK: flatMap
// 1. flatten하게 만듬
// 2. nil을 제거
// 3. 옵셔널 바인딩
let flatMapTest1 = array1.flatMap { $0 }

// MARK: compactMap
// 1차원 배열에서
// 옵셔널 바인딩하고싶을 때
let compactMapTest1 = array1.compactMap { $0 }

print("flatMapTest1 \(flatMapTest1)")
print("compactMapTest1 \(compactMapTest1)")

// result
// flatMapTest1 [1, 3, 5, 6, 7]
// compactMapTest1 [1, 3, 5, 6, 7]

// MARK: 2차원 배열의 경우
let array2 = [[1, 2, 3], [nil, 5], [6, nil], [nil, nil]]

// MARK: flatMap
// 2차원 배열을 1차원 배열로 flatten 하게 만들어줌
let flatMapTest2 = array2.flatMap { $0 }

// MARK: compactMap
// 2차원 배열을 1차원 배열로 flatten 하게 만들어주지않음
let compactMapTest2 = array2.compactMap { $0 }

print("flatMapTest2 \(flatMapTest2)")
print("compactMapTest2 \(compactMapTest2)")

let flatMapAndCompactMapTest1 = array2.flatMap { $0 }.compactMap { $0 }
print("flatMapAndCompactMapTest1 \(flatMapAndCompactMapTest1)")
print(" =================================================== \n")
// result
// flatMapTest2 [Optional(1), Optional(2), Optional(3), nil, Optional(5), Optional(6), nil, nil, nil]
// compactMapTest2 [[Optional(1), Optional(2), Optional(3)], [nil, Optional(5)], [Optional(6), nil], [nil, nil]]

// flatMapAndCompactMapTest1 [1, 2, 3, 5, 6]

// MARK: for-in
// break, continue을 사용할 수 있고, return를 이용하면 에러가 납니다.
print(" =================================================== ")
print("forEach\n")
for number in array {
    print("number = \(number)")
}

// MARK: forEach
// break, continue 구문을 사용할 수 없고, return을 통해서 빠져나갈 수 있습니다. (continue처럼 동작함)
array.forEach { print("$0 = \($0)") }

print(" =================================================== \n")

print(" =================================================== ")
print("Filter\n")
let filterTest1 = names.filter { $0 == "Rx"}
let filterTest2 = array.filter { $0 % 2 == 0 }
print("filterTest1 = \(filterTest1)")
print("filterTest2 = \(filterTest2)")
print(" =================================================== \n")

// MARK: Reduce
// 문자열이든, 정수든 내부를 하나로 합쳐주는 기능을 한다.
// 첫 번째 매겨변수는 초깃값이고, 최초의 값($0)으로 사용된다.
print(" =================================================== ")
print("Reduce\n")

let reduceTest1 = (1...50).reduce(0) { (sum, nextValue) -> Int in
    return sum + nextValue
}
print("reduceTest1 = \(reduceTest1)")
print("(1...50).reduce(0) { $0 + $1 } = \((1...50).reduce(0) { $0 + $1 })")


// result
// 1275

let reduceTest2 = ["1", "2", "3", "4", "5"].reduce("") { (strSum, str) in
    return strSum + str
}
let reduceTest3 = ["1", "2", "3", "4", "5"].reduce("") { $0 + $1 }
print("reduceTest2 = \(reduceTest2)")
print("reduceTest3 = \(reduceTest3)")

print(" =================================================== \n")

