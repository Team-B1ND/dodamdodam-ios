//
//  PatchMemberPermissionRequest.swift
//  Domain
//
//  Created by dgsw8th61 on 2/15/25.
//

import Foundation

public struct PatchMemberPermissionRequest: RequestProtocol {
    public let permission: DivisionPermission
    
    public init(permission: DivisionPermission) {
        self.permission = permission
    }
}
