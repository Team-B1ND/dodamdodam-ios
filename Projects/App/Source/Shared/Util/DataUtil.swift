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

public func getDate(_ type: DateType) -> Int {
    
    let currentDate = Date()
    let calendar = Calendar.current
    
    let year = calendar.component(.year, from: currentDate)
    let month = calendar.component(.month, from: currentDate)
    let day = calendar.component(.day, from: currentDate)
    
    switch type {
    case .year:
        return year
    case .month:
        return month
    case .day:
        return day
    }
}

public extension String {
    func parseDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: self) else {
            return nil
        }
        return date
    }
}
