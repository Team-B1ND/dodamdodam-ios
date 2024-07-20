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
}

public func getDate(_ type: DateType, date: Date = .now) -> Int {
    let calendar = Calendar.current
    
    let year = calendar.component(.year, from: date)
    let month = calendar.component(.month, from: date)
    let day = calendar.component(.day, from: date)
    
    switch type {
    case .year:
        return year
    case .month:
        return month
    case .day:
        return day
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
