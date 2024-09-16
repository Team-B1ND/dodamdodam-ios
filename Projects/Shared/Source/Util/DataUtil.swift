//
//  DataUtil.swift
//  DodamDodam
//
//  Created by 이민규 on 4/2/24.
//

import Foundation

public func calculatingDateProgress(
    startAt: Date,
    endAt: Date
) -> Double {
    let currentDate = Date()
    
    if currentDate <= startAt {
        return 0.0
    } else if currentDate >= endAt {
        return 1.0
    } else {
        let elapsedTime = currentDate.timeIntervalSince(startAt)
        let totalDuration = endAt.timeIntervalSince(startAt)
        let progress = elapsedTime / totalDuration
        return progress
    }
}
