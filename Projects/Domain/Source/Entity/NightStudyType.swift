//
//  NightStudyType1.swift
//  Domain
//
//  Created by dgsw01 on 6/5/25.
//

import Foundation

public enum NightStudyType: String, Codable, CaseIterable, Hashable {
    case type1 = "NIGHT_STUDY_1"
    case type2 = "NIGHT_STUDY_2"
    case type3 = "NIGHT_STUDY_3"
    
    public var displayName: String {
        switch self {  
        case .type1:
            return "심자 1"
        case .type2:
            return "심자 2"
        case .type3:
            return "심자 3"
        }
    }
}
