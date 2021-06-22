//
//  DiaryDate.swift
//  finalProject
//
//  Created by Lin Li on 2021/6/22.
//

import Foundation

var monthInt = ""
var diaryDate = ""

func diaryDateFormat(year: String, month: String, date: String) -> String {
    switch month {
        case "January":
            monthInt = "01"
            break
        case "Febuary":
            monthInt = "02"
            break
        case "March":
            monthInt = "03"
            break
        case "April":
            monthInt = "04"
            break
        case "May":
            monthInt = "05"
            break
        case "June":
            monthInt = "06"
            break
        case "July":
            monthInt = "07"
            break
        case "August":
            monthInt = "08"
            break
        case "September":
            monthInt = "09"
            break
        case "October":
            monthInt = "10"
            break
        case "November":
            monthInt = "11"
            break
        case "December":
            monthInt = "12"
            break
        default:
            break
    }

    if ((Int(date) ?? 0) < 10 ) {
        diaryDate = "\(year)-\(monthInt)-0\(date)"
    }
    else if ((Int(date) ?? 0) == 0) {
        print ("Error")
    }
    else {
        diaryDate = "\(year)-\(monthInt)-\(date)"
    }
    print ("Diary Date: \(diaryDate)")
    return diaryDate
}
