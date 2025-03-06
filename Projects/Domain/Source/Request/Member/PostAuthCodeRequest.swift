//
//  PostAuthCodeRequest.swift
//  Domain
//
//  Created by hhhello0507 on 2/13/25.
//

import Foundation

public struct PostAuthCodeRequest: RequestProtocol {
    
    public let identifier: String
    
    public init(identifier: String) {
        self.identifier = identifier
    }
}
