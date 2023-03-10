//: [Previous](@previous)

import Foundation

class User {
    var id: String?
    var pw: String?
    
    static let shared: User = {
        
        let instance = User()
        // setup code
        return instance
    }()
    
    func getUserInfo() {
        print("getUserInfo")
        print(id ?? "", pw ?? "")
    }
}

class A {
    var user: User = User()
    
}

class B {
    var user: User = User()
}

var viewControllerA = A()
var viewControllerB = B()
viewControllerA.user.id = "Son"
viewControllerB.user.pw = "5678"


print("id = \(String(describing: viewControllerA.user.id)), pw = \(String(describing: viewControllerA.user.pw))")
print("id = \(String(describing: viewControllerB.user.id)), pw = \(String(describing: viewControllerB.user.pw))\n")

viewControllerB.user = viewControllerA.user
print("viewControllerA.user -> viewControllerB.user 전달 후")
print("id = \(String(describing: viewControllerA.user.id)), pw = \(String(describing: viewControllerA.user.pw))")
print("id = \(String(describing: viewControllerB.user.id)), pw = \(String(describing: viewControllerB.user.pw))\n")
viewControllerB.user.pw = "5678"
print("viewControllerB.user.pw 할당 이후")
print("id = \(String(describing: viewControllerA.user.id)), pw = \(String(describing: viewControllerA.user.pw))")
print("id = \(String(describing: viewControllerB.user.id)), pw = \(String(describing: viewControllerB.user.pw))\n")



//let userManagerExample = UserManager() // 직접 객체 생성 X
let userManager = User.shared
//address(of: &userManager)


userManager.getUserInfo()

print("userManager id = \(String(describing: userManager.id)), pw = \(String(describing: userManager.pw))")
userManager.id = "Son"
print("userManager id = \(String(describing: userManager.id)), pw = \(String(describing: userManager.pw))") //Son

let userManager2 = User.shared
print("userManager2 id = \(String(describing: userManager2.id)), pw = \(String(describing: userManager2.pw))") //Son


enum AuthType {
    case hp
    case email
}
func requestUserAuthNumber(type: AuthType, to hporEmail: String, authNumber: String) {
    
    
}
let hp = ""
let email = ""
let authNumber = ""
requestUserAuthNumber(type: .email, to: hp, authNumber: authNumber)


//: [Next](@next)
