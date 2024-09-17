//
//  MealType.swift
//  Domain
//
//  Created by hhhello0507 on 8/12/24.
//

import Foundation

public enum MealType: Int, RawRepresentable {
    case breakfast
    case lunch
    case dinner
    
    public var label: String {
        switch self {
        case .breakfast:
            "아침"
        case .lunch:
            "점심"
        case .dinner:
            "저녁"
        }
    }
    
    public static func from(_ date: Date) -> Self? {
        switch (date[.hour], date[.minute]) {
        case (0...8, _), (8, ..<20):
                .breakfast // 아침: ~ 8:20
        case (8, 21...60), (8...13, _), (13, 0..<30): 
                .lunch // 점심: 8:21 ~ 13:30
        case (13, 0...30), (13...19, _), (19, 0..<10): 
                .dinner // 저녁: 13:31 ~ 19:10
        default: nil
        }
    }
}
extension Date {
    subscript(components: Calendar.Component) -> Int {
        var calendar = Calendar.current
        calendar.locale = .init(identifier: "ko_KR")
        return calendar.dateComponents([components], from: self).value(for: components)!
    }
}
