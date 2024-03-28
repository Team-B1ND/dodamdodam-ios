//
//  BannerRepository.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

protocol BannerRepository {
    
    func fetchActiveBanner() async throws -> BannerResponse
}
