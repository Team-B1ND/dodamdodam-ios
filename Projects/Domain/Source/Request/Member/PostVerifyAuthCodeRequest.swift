//
//  PostVerifyAuthCodeRequest.swift
//  Domain
//
//  Created by hhhello0507 on 2/13/25.
//

import Foundation

public struct PostVerifyAuthCodeRequest: RequestProtocol {
    
    public let identifier: String
    public let authCode: String
    
    public init(identifier: String, authCode: String) {
        self.identifier = identifier
        self.authCode = authCode
    }
}
