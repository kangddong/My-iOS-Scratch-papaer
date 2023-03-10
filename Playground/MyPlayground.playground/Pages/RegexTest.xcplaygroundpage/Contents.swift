//: [Previous](@previous)

import Foundation

func isEmail(email: String) -> Bool {
//    do {
//
//        //let regex = try NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])+\\.(?:\\.[a-zA-Z0-9]+(?:[a-zA-Z0-9-]{2,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
//        let regex = try NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
//
//        return regex.firstMatch(in: email, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, email.count)) != nil
//    } catch {
//        print("catch false")
//        return false
//    }
    
    //let regex = "[A-Z0-9a-z._$+-]+@[A-Z0-9a-z._]+\\.[A-Za-z]{2.64}"
    //let emailTest = NSPredicate(format: "SELF MATCHES %@", regex)
    //print("do return")
    //return emailTest.evaluate(with: email)
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    let result = emailTest.evaluate(with: email)
    print("email pass/fail \(result)")
    return result
}

func isPhoneNumber(hp: String) -> Bool {
    
    let PHONE_REGEX = "(01[0-9]|217)([0-9]{3,4})([0-9]{4})"
    let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
    let result =  phoneTest.evaluate(with: hp)
    print("hp pass/fail \(result)")
    return result
}

let testEmail = "rkdehddud92@naver.k.rr"

isEmail(email: testEmail)
isPhoneNumber(hp: "01044010641")
//: [Next](@next)
