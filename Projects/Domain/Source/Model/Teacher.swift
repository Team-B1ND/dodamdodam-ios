//
//  Teacher.swift
//  DodamDodam
//
//  Created by Mercen on 3/28/24.
//

import Foundation
import SwiftBok

@Init()
@Members()
public struct Teacher: Codable, Hashable {
    
    public let id: Int?
    public let tel: String
    public let position: String
}
