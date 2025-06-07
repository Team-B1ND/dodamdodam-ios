//
//  NightStudyProjectType.swift
//  Domain
//
//  Created by dgsw01 on 5/6/25.
//

import Foundation

public enum NightStudyProjectType: String, Codable, CaseIterable, Hashable {
    case project1 = "NIGHT_STUDY_PROJECT_1"
    case project2 = "NIGHT_STUDY_PROJECT_2"
    case project3 = "NIGHT_STUDY_PROJECT_3"
    
    public var displayName: String {
        switch self {
        case .project1:
            return "심자 1"
        case .project2:
            return "심자 2"
        case .project3:
            return "심자 3"
        }
    }
}
