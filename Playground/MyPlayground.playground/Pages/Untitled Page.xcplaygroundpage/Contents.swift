//: [Previous](@previous)

import Foundation

struct UserInfo {
    let name: String
    let sex: String
}

let userList: [UserInfo] = [
                            UserInfo(name: "홍길동", sex: "M"),
                            UserInfo(name: "춘향이", sex: "W"),
                            UserInfo(name: "손흥민", sex: "M"),
                            UserInfo(name: "Gareth Bale", sex: "M"),
                            ]
for user in userList {
    
    print("Name = \(user.name)")
    print("Sex = \(user.sex)")
}

userList.forEach { user in
    print("Name = \(user.name)")
    print("Sex = \(user.sex)")
}

userList.forEach { print("Name = \($0.name), Sex = \($0.sex)") }

//: [Next](@next)

