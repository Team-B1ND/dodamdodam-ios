//
//  StringExt.swift
//  DodamDodam
//
//  Created by dgsw8th71 on 3/23/24.
//

extension StringProtocol {
    subscript(offset: Int) -> Character { self[index(startIndex, offsetBy: offset)] }

    subscript (bounds: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start..<end])
    }
}
