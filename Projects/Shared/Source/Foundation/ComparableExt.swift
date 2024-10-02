//
//  Comparable.swift
//  Shared
//
//  Created by hhhello0507 on 8/13/24.
//

import Foundation

public extension Comparable {
    func clamped(to limits: ClosedRange<Self>) -> Self {
        return min(max(self, limits.lowerBound), limits.upperBound)
    }
}
