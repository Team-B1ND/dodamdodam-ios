//
//  Student.swift
//  DodamDodam
//
//  Created by Mercen on 3/28/24.
//

import Foundation
import SwiftBok

@Init()
@Members()
public struct Student: Codable, Hashable {
    
    public let id: Int
    public let name: String
    public let grade: Int
    public let room: Int
    public let number: Int
}
