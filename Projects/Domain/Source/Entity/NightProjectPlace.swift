//
//  NightProjectPlace.swift
//  Domain
//
//  Created by dgsw30 on 4/18/25.
//

import Foundation

public enum NightProjectPlace: String, Codable, CaseIterable, Hashable {
    
    case lab12 = "LAB_12"
    case lab13 = "LAB_13"
    case lab14 = "LAB_14"
    case lab15 = "LAB_15"
    
    public var displayName: String {
        switch self {
        case .lab12:
            "랩12실"
        case .lab13:
            "랩13실"
        case .lab14:
            "랩14실"
        case .lab15:
            "랩15실"
        }
    }
}
