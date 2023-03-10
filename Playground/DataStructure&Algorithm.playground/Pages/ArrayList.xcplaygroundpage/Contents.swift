////: [Previous](@previous)
//
//import Foundation
//
//struct arrayList {
//    var array: [Int?]
//    var numberOfData : Int
//    var currentPosition : Int
//}
//
//class ArrayList {
//
//    let listLength = 100
//
//    func listInit(inout list: arrayList) {
//        list.array = [Int?](count: listLength, repeatedValue: nil)
//        list.numberOfData = 0
//        list.currentPosition = -1
//    }
//
//    func listInsert(inout list: arrayList, data: Int) {
//        if list.numberOfData > listLength {
//            print("impossible Save")
//            return
//        }
//
//        list.array[list.numberOfData] = data
//        list.numberOfData = list.numberOfData + 1
//
//    }
//
//    func listFirst(inout list: arrayList, inout data: Int) -> Bool {
//        if list.numberOfData == 0 {
//            return false
//        }
//
//        list.currentPosition = 0
//        data = list.array[0]!
//        return true
//    }
//
//    func listNext(inout list: arrayList, inout data: Int) -> Bool {
//        if list.currentPosition >= list.numberOfData - 1 {
//            return false
//        }
//
//        list.currentPosition = list.currentPosition + 1
//        data = list.array[list.currentPosition]!
//        return true
//    }
//
//    func listRemove(inout list: arrayList) -> Int? {
//        let removePosition = list.currentPosition
//
//        let removeData = list.array[removePosition]
//
//        for i in 0..<list.array.count-1 {
//            list.array[i] = list.array[i+1]
//        }
//
//        list.numberOfData = list.numberOfData - 1
//        list.currentPosition = list.currentPosition - 1
//
//        return removeData
//    }
//
//    func listCount(list: arrayList) -> Int {
//        return list.numberOfData
//    }
//
//}
//
//func main() {
//
//    var data : Int = 0
//    var list = arrayList.init(array: [Int?](), numberOfData: -1, currentPosition: -1)
//
//    ArrayList().listInit(&list)
//
//    // Save Data
//    ArrayList().listInsert(&list, data: 1);
//    ArrayList().listInsert(&list, data: 2);
//    ArrayList().listInsert(&list, data: 3);
//    ArrayList().listInsert(&list, data: 4);
//
//    print("number of current data : \(ArrayList().listCount(list))")
//
//
//    if (ArrayList().listFirst(&list, data: &data)) {
//        print("\(data) ", terminator:"")
//
//        while(ArrayList().listNext(&list, data: &data)) {
//            print("\(data) ", terminator:"")
//        }
//    }
//
//    print("")
//
//
//    // Delete Data
//    if (ArrayList().listFirst(&list, data: &data)) {
//        print(data)
//        if (data == 1) {
//            data = ArrayList().listRemove(&list)!;
//        }
//
//        while(ArrayList().listNext(&list, data: &data)) {
//            if (data == 1) {
//                data = ArrayList().listRemove(&list)!;
//            }
//        }
//    }
//
//    print("number of current data : \(ArrayList().listCount(list))")
//
//    if (ArrayList().listFirst(&list, data: &data)) {
//        print("\(data) ", terminator:"")
//
//        while(ArrayList().listNext(&list, data: &data)) {
//            print("\(data) ", terminator:"")
//        }
//    }
//}
//
//main()
//
////: [Next](@next)
