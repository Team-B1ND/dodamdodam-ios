//
//  MealType.swift
//  Domain
//
//  Created by hhhello0507 on 8/12/24.
//

import Foundation
import SwiftBok

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
}
