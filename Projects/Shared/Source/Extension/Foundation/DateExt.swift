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
}
