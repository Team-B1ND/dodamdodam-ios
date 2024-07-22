//
//  BannerRepository.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

public protocol BannerRepository: RepositoryProtocol {
    
    func fetchActiveBanner() async throws -> [BannerResponse]
}
