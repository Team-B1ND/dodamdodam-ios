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

public func cutArray<T>(array: [T]) -> [[T]] { // 배열을 6개씩 반 자르기
    let firstHalf = Array(array[0..<6])
    let secondHalf = Array(array[6..<array.count])
    return [firstHalf, secondHalf]
}
