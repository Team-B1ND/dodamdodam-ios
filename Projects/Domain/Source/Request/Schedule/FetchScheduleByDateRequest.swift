//
//  FetchScheduleByDateRequest.swift
//  DodamDodam
//
//  Created by Mercen on 3/27/24.
//
import SwiftBok

@Init()
@Members()
public struct FetchScheduleByDateRequest: RequestProtocol {
    
    public let year: Int
    public let month: Int
    public let day: Int
}
