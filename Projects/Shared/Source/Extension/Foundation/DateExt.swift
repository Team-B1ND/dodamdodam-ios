//
//  DateExt.swift
//  DodamDodam
//
//  Created by 이민규 on 4/3/24.
//

import Foundation

public extension Date {
    
    func parseString(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "ko_KR")
        return dateFormatter.string(from: self)
    }
    
    var remainingTimeText: String {
        let now = Date()
        let components = Calendar.current.dateComponents([.day, .hour, .minute], from: now, to: self)
        
        return if let days = components.day, days > 0 {
            "\(days)일"
        } else if let hours = components.hour, let minutes = components.minute {
            "\(hours)시간 \(minutes)분"
        } else {
            "-"
        }
    }
    
    var nightStudyRemainingTimeText: String {
        let now = Date()
        let components = Calendar.current.dateComponents([.day], from: now, to: self)
        
        guard let days = components.day else {
            return "-"
        }
        return "\(days + 1)일"
    }
    
    subscript(components: Calendar.Component) -> Int? {
        var calendar = Calendar.current
        calendar.locale = .init(identifier: "ko_KR")
        return calendar.dateComponents([components], from: self).value(for: components)
    }
    
    func equals(_ other: Date, components: Set<Calendar.Component>) -> Bool {
        var calendar = Calendar.current
        calendar.locale = .init(identifier: "ko_KR")
        let selfComponents = calendar.dateComponents(components, from: self)
        let otherComponents = calendar.dateComponents(components, from: other)
        return selfComponents == otherComponents
    }
    
    var weeklyDates: [Date] {
        var calendar = Calendar.current
        calendar.locale = .init(identifier: "ko_KR")
        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))!
        return (0..<7).compactMap { number in
            if let date = calendar.date(byAdding: .day, value: number, to: startOfWeek) {
                date
            } else {
                nil
            }
        }
    }
    
    var range: Int? {
        let calendar = Calendar.current
        return calendar.range(of: .day, in: .month, for: self)?.count
    }
    
    // self의 month를 기준으로 calendar 생성
    // nil: 이전 month 혹은 다음 month
    var weeks: [[Date?]] {
        let calendar = Calendar.current
        // 해당 월의 첫째 날
        var components = calendar.dateComponents([.year, .month], from: self)
        components.day = 1
        let firstDayOfMonth = calendar.date(from: components)!
        
        // 첫째 날의 요일 (일요일 = 1, 월요일 = 2, ..., 토요일 = 7)
        let firstWeekday = calendar.component(.weekday, from: firstDayOfMonth)
        
        // 날짜 배열 생성
        var days: [Date?] = Array(repeating: nil, count: firstWeekday - 1)
        days += Array(1...(range ?? 0)).compactMap {
            components.day = $0
            return calendar.date(from: components)
        }
        days += Array(repeating: nil, count: (7 - days.count % 7) % 7)
        
        // 주 단위로 배열을 나눔
        return stride(from: 0, to: days.count, by: 7).map {
            Array(days[$0..<$0 + 7])
        }
    }
}
