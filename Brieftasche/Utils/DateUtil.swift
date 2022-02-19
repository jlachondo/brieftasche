//
//  DateUtil.swift
//  Brieftasche
//
//  Created by Lloyd on 2/19/22.
//

import Foundation

func getCurrYear(calendar: Calendar) -> String {
    let year = calendar.component(.year, from: Date())
    return String(year)
}

func getCurrMonth(calendar: Calendar) -> String {
    let month = calendar.component(.month, from: Date())
    return String(month)
}

func getCurrWeekOfYear(calendar: Calendar) -> String {
    let week = calendar.component(.weekOfYear, from: Date())
    return String(week)
}

func getCurrDay(calendar: Calendar) -> String {
    let day = calendar.component(.day, from: Date())
    return String(day)
}

func getDateFormatter() -> DateFormatter {
    let dateFormatter = DateFormatter()
    let timezone = TimeZone.current.abbreviation() ?? "GMT"
    dateFormatter.timeZone = TimeZone(abbreviation: timezone)
    // dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
    dateFormatter.dateFormat = "hh:mm a"
    dateFormatter.amSymbol = "AM"
    dateFormatter.pmSymbol = "PM"

    return dateFormatter
}
