//
//  PatchMemberInfoRequest.swift
//  DodamDodam
//
//  Created by Mercen on 3/27/24.
//

public struct PatchMemberInfoRequest: RequestProtocol {
    
    public let email: String?
    public let name: String?
    public let profileImage: String?
    
    public init(email: String?, name: String?, profileImage: String?) {
        self.email = email
        self.name = name
        self.profileImage = profileImage
    }
}
