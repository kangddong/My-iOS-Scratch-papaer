import Foundation
import Combine


let arrayPublisher = [1, 3, 5, 7, 9].publisher

let queue = DispatchQueue(label: "custom")

// if 작업이 Heavy한 경우에 main thread에서 도는 것은 권장하지않기 때문에 만들어진 custom queue thread에서 동작해야한다.
// transform: 1, thread: <NSThread: 0x600003d9e800>{number = 4, name = (null)} number가 1은 main
// thread safe하게 할려면 어떤 thread에서 할지 고려해서 작업해야한다.

let subscription2 = arrayPublisher
    .subscribe(on: queue) // custom queue에서 돌아라 !!!
    .map { value -> Int in
        print("transform: \(value), thread: \(Thread.current)") // Operator map 추가
        return value
    }
    .receive(on: DispatchQueue.main) // Data 받는건 main에서 받아라 !!
    .sink { value in
    print("Received Value: \(value), thread: \(Thread.current)")
}
