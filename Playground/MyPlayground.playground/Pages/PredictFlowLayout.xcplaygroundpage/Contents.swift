//: [Previous](@previous)

import Foundation

protocol TestDelegate {
    func cellForRowAt()
}

protocol TestDelegateFlowLayout: TestDelegate {
    func sizeItem()
}


class FakeViewController {
    
    var tableView: FakeTableView = FakeTableView()
    
    func configureTableView() {
        tableView.testDelegate = self
    }
}

extension FakeViewController: TestDelegateFlowLayout {
    
    func sizeItem() {
        print("sizeItem")
    }
}

extension FakeViewController: TestDelegate {
    
    func cellForRowAt() {
        print("cellForRowAt")
    }
}

class FakeTableView {
    
    var testDelegate: TestDelegateFlowLayout?
    
    func test1() {
        testDelegate?.cellForRowAt()
    }
    
    func test2() {
        testDelegate?.sizeItem()
    }
}

let vc = FakeViewController()
vc.configureTableView()


vc.tableView.test1()
vc.tableView.test2()

//: [Next](@next)
