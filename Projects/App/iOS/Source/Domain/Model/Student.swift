//
//  Student.swift
//  DodamDodam
//
//  Created by Mercen on 3/28/24.
//

import Foundation

struct Student: Codable, Hashable {
    
    let id: Int
    let name: String
    let grade: Int
    let room: Int
    let number: Int
}
