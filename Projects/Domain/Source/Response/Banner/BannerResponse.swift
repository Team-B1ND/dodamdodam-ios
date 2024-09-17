//
//  BannerResponse.swift
//  DodamDodam
//
//  Created by Mercen on 3/27/24.
//
import Foundation
public struct BannerResponse: ResponseProtocol {
    
    public let expireAt: Date
    public let id: Int
    public let imageUrl: String
    public let redirectUrl: String
    public let status: ActiveStatus
    public let title: String
    public init(expireAt: Date, id: Int, imageUrl: String, redirectUrl: String, status: ActiveStatus, title: String) {
        self.expireAt = expireAt
        self.id = id
        self.imageUrl = imageUrl
        self.redirectUrl = redirectUrl
        self.status = status
        self.title = title
    }
}
