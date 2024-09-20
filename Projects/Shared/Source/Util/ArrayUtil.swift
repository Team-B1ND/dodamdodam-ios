//
//  ArrayExt.swift
//  Shared
//
//  Created by hhhello0507 on 8/12/24.
//

import Foundation

public func splitArray<T>(array: [T]) -> [[T]] {
    let middleIndex: Int = Int(ceil(Double(array.count) / 2.0))
    let firstHalf = Array(array[0..<middleIndex])
    let secondHalf = Array(array[middleIndex..<array.count])
    return [firstHalf, secondHalf]
}
