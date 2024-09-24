//
//  Place.swift
//  DodamDodam
//
//  Created by Mercen on 3/27/24.
//

import Foundation

public enum Place: String, Codable, CaseIterable, Hashable {

    case programming1 = "PROGRAMMING_1"
    case programming2 = "PROGRAMMING_2"
    case programming3 = "PROGRAMMING_3"
    case korean = "KOREAN"
    case math = "MATH"
    case society = "SOCIETY"
    case hall = "HALL"
    case audiovisual_room = "AUDIOVISUAL_ROOM"
    case none = "NONE"
    case etc = "ETC"
}
