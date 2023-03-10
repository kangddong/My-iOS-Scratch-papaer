import Foundation

enum Status {
    case success
    case fail
}

func testTuple(value: (status: Status, failCount: Int, failMsg: String, crpNo: Int)) {
    print(value)
}
//val pair2 = Pair(.fail, count)
//let value = (status: Status.fail, 3, "message", 120)
let value2 = (status: Status.fail, failCount: 3, failMsg: "message", crpNo: 120)

let status = Status.fail
let failCount =  3
let failMsg = "message"
let crpNo = 120
//testTuple(value: value2)
//testTuple(value: (status: value2.status, failCount: value2.failCount, failMsg: value2.failMsg, crpNo: value2.crpNo))
//testTuple(value: (status: status, failCount: failCount, failMsg: failMsg, crpNo: crpNo))




