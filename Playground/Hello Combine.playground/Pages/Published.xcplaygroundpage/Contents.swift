import UIKit
import Combine

// Published

final class SomeViewModel {
    @Published var name: String = "Hello"
    var age: Int = 20
}

final class Label {
    var text: String = ""
}

let label = Label()
let vm = SomeViewModel()
print("text: \(label.text)")

vm.$name.assign(to: \.text, on: label) //$ 사인은 퍼블리셔; '퍼블리셔에서 생긴 Data를 label의 text에 할당한다.'는 구문
//vm.$name.sink { value in
//    label.text = value
//}
print("text: \(label.text)")

vm.name = "Kang"
print("text: \(label.text)")

vm.name = "Rx"
print("text: \(label.text)")

//Data가 변경될 때마다 UILabel에 바로 업데이트가 가능하다.
