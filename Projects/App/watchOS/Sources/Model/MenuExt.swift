//
//  MenuExt.swift
//  DodamDodam
//
//  Created by 김은찬 on 6/21/25.
//

import Foundation
import Domain

extension MealModel {
    var menuList: [String] {
        [breakfast, lunch, dinner]
            .compactMap { $0 }
            .flatMap { $0.details }
            .map { $0.name }
            .filter { !$0.isEmpty }
    }
}
