//
//  BannerResponse.swift
//  DodamDodam
//
//  Created by Mercen on 3/27/24.
//

import Foundation

struct BannerResponse: ResponseProtocol {
    
    let expireAt: String
    let id: Int
    let imageUrl: String
    let redirectUrl: String
    let status: ActiveStatus
    let title: String
}
