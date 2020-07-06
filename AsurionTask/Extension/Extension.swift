//
//  String+Extension.swift
//  AsurionTask
//
//  Created by Yogesh Ingole on 30/06/20.
//  Copyright © 2020 Kalpesh Mahajan. All rights reserved.
//

import UIKit

extension String
{
    func checkWorkingHours()->String
    {
       // let workingHours = "M-F 6:00 - 18:00"

        let arr = self.components(separatedBy: " ")

        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        var message = "Something Went wrong!"

        if let fromDate = dateFormatter.date(from: arr[1]),let toDate = dateFormatter.date(from: arr[3])
        {
            print(fromDate.hour12)
            print(toDate.hour12)

            
            let now = Date()
            print(now.hour12)

            if now.hour12 >= fromDate.hour12 && now.hour12 <= toDate.hour12 {

                message = "Thank you for getting in touch with us. We’ll get back to you as soon as possible"
            }
            else
            {
                message = "Work hours has ended. Please contact us again on the next work day"
            }

    }
        return message
    }
}
extension Formatter {

    static let hour12: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH"
        return formatter
    }()
    static let minute0x: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM"
        return formatter
    }()

}
extension Date {

    var hour12:  String      { return Formatter.hour12.string(from: self) }
    var minute0x: String     { return Formatter.minute0x.string(from: self) }

}
