import Foundation

// 시간을 재기위해 만든 함수
public func timeCheck(_ block: () -> ()) -> TimeInterval {
  let start = Date()
  block()
  return Date().timeIntervalSince(start)
}

public func address(of object: UnsafeRawPointer) -> String{
    let address = Int(bitPattern: object)
    return String(format: "%p", address)
}
