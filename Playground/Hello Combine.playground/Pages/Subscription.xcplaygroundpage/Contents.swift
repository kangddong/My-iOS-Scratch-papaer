import UIKit
import Combine

// Subscription
let subject = PassthroughSubject<String, Never>()
let subscription = subject
    .print("[Debug]") // 관계 Debug 용도 String을 Prefix로 사용가능하다.
    .sink { value in
    print("Subscriber received Value: \(value)")
}

subject.send("Hello")
subject.send("Hello Again!")
subject.send("Hellor for the last time!")
//subject.send(completion: .finished) // 관계가 끝남
subscription.cancel()
subject.send("Hello ?? :(")
let arrayPublisher = [1, 3, 5, 7, 9].publisher



/*
 .print() completion: .finished의 경우
 
 receive subscription: (PassthroughSubject)
 request unlimited
 receive value: (Hello)
 Subscriber received Value: Hello
 receive value: (Hello Again!)
 Subscriber received Value: Hello Again!
 receive value: (Hellor for the last time!)
 Subscriber received Value: Hellor for the last time!
 receive finished
 
 subscription.cancel() 구독취소할 때
 receive subscription: (PassthroughSubject)
 request unlimited
 receive value: (Hello)
 Subscriber received Value: Hello
 receive value: (Hello Again!)
 Subscriber received Value: Hello Again!
 receive value: (Hellor for the last time!)
 Subscriber received Value: Hellor for the last time!
 receive cancel
 */
