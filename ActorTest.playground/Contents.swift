import UIKit

struct Pair<T, U> {
    var first: T
    var second: U
}

// 적절한 경우 where 적합성을 사용하여 Sendable을 전파할 수 있다.
extension Pair: Sendable where T: Sendable, U: Sendable {
}


