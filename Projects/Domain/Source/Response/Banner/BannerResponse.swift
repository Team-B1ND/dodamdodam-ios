//
//  BannerResponse.swift
//  DodamDodam
//
//  Created by Mercen on 3/27/24.
//
import Foundation
import SwiftBok

@Init()
@Members()
public struct BannerResponse: ResponseProtocol {
    
    public let expireAt: Date
    public let id: Int
    public let imageUrl: String
    public let redirectUrl: String
    public let status: ActiveStatus
    public let title: String
}
