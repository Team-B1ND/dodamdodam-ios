//
//  SchedulePlace.swift
//  Domain
//
//  Created by dgsw8th36 on 11/18/24.
//

import Foundation

public enum SchedulePlace: String, Codable, CaseIterable, Hashable {

    case programming1 = "PROGRAMMING_1"
    case programming2 = "PROGRAMMING_2"
    case programming3 = "PROGRAMMING_3"
    case korean = "KOREAN"
    case math = "MATH"
    case society = "SOCIETY"
    case hall = "HALL"
    case audiovisualRoom = "AUDIOVISUAL_ROOM"
    case none = "NONE"
    case etc = "ETC"
}
