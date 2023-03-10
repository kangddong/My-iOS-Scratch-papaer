//: [Previous](@previous)

import Foundation

var showOnlyToday: Bool = false

var startDate: Date
var endDate: Date
var montlyDate: Date
   
switch showOnlyToday {
case true:
    startDate = Date()
    endDate = Date()
    montlyDate = Date()
case false:
    var startDateee = Date().getFirstOfMonthDateText()
    
    //var convertDate = startDateee.convertToDate(format: "yyyy.MM.dd")
    //startDate = convertDate ?? Date()
    startDate = startDateee.convertToDate(format: "yyyy.MM.dd") ?? Date()
    endDate = Date()
    montlyDate = Date()
}



extension Date {
    /// get String with format
    func getDateText(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        let text = formatter.string(from: self)
        return text
    }
    
    func getFirstOfMonthDateText(withFormat format: String = "yyyy.MM.") -> String {
        let result = Date().getDateText(format: format) + "01"
        return result
    }
}

extension String {
    func convertToDate(format: String) -> Date? {
        let form = DateFormatter()
        form.dateFormat = format
        form.locale = Locale.current
        form.timeZone = TimeZone(secondsFromGMT: 9)

        let text = self
        let value = form.date(from: text)
        
        return value
    }
}
