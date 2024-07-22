//
//  StringExt.swift
//  DodamDodam
//
//  Created by dgsw8th71 on 3/23/24.
//

import Foundation

public extension StringProtocol {
    
    subscript(offset: Int) -> Character { self[index(startIndex, offsetBy: offset)] }
    
    subscript (bounds: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start..<end])
    }
}

public extension String {
    
    func parseDate(format: String) -> Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "ko_KR")
        guard let date = dateFormatter.date(from: self) else {
            return nil
        }
        return date
    }
}
