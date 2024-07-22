//
//  PointResponse.swift
//  DodamDodam
//
//  Created by Mercen on 3/28/24.
//
import SwiftBok

@Init()
@Members()
public struct PointResponse: ResponseProtocol {
    
    public let id: Int
    public let student: Student
    public let teacher: Teacher
    public let reason: PointReason
    public let issueAt: String
}
