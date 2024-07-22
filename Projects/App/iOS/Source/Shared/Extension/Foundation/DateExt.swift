//
//  DateExt.swift
//  DodamDodam
//
//  Created by 이민규 on 4/3/24.
//

import Foundation

public extension Date {
    
    func parseString(format: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "ko_KR")
        return dateFormatter.string(from: self)
    }
}
