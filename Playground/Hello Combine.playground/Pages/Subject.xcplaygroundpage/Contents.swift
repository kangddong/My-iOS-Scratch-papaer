import UIKit
import Combine

// Subject
let relay = PassthroughSubject<String, Never>() //<성공, 실패> Never는 실패할 일이 없을 때
let subscription1 = relay.sink { value in
    print("subscription1 Value: \(value)")
}

relay.send("Hello")
relay.send("World !")

let variable = CurrentValueSubject<String, Never>("")
let subscription2 = variable.sink { value in
    print("subscription2 Value: \(value)")
}

//variable.send("More Text") // 기존에 가지고 있던 값을 보여진다

let publisher = ["Here", "we", "go"].publisher
//publisher.subscribe(relay)
publisher.subscribe(variable)

