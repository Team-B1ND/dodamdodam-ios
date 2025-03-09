//
//  ClubRegisterTimeResponse.swift
//  Domain
//
//  Created by dgsw30 on 3/8/25.
//

import Foundation

public struct ClubRegisterTimeResponse: ResponseProtocol {
    public let createStart: String
    public let createEnd: String
    public let applicantStart: String
    public let applicantEnd: String
    
    public init(createStart: String, createEnd: String, applicantStart: String, applicantEnd: String) {
        self.createStart = createStart
        self.createEnd = createEnd
        self.applicantStart = applicantStart
        self.applicantEnd = applicantEnd
    }
}
