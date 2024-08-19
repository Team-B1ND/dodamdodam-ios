//
//  DataUtil.swift
//  DodamDodam
//
//  Created by 이민규 on 4/2/24.
//

import Foundation

public enum DateType: Int {
    case year = 0
    case month = 1
    case day = 2
    case hour = 3
    case minute = 4
    case second = 5
}

public func getDate(_ type: DateType, date: Date = .now) -> Int {
    var calendar = Calendar.current

    return switch type {
    case .year:
        calendar.component(.year, from: date)
    case .month:
        calendar.component(.month, from: date)
    case .day:
        calendar.component(.day, from: date)
    case .hour:
        calendar.component(.hour, from: date)
    case .minute:
        calendar.component(.minute, from: date)
    case .second:
        calendar.component(.second, from: date)
    }
}

public func calculatingDateProgress(
    startAt: Date,
    endAt: Date,
    dateFormat: String
) -> Double {
    let currentDate = Date()
    
    if currentDate <= startAt {
        return 0.0
    } else if currentDate >= endAt {
        return 1.0
    } else {
        let elapsedTime = currentDate.timeIntervalSince(startAt)
        let totalDuration = endAt.timeIntervalSince(startAt)
        let progress = elapsedTime / totalDuration
        return progress
    }
}
