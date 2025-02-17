//
//  NoticeRepository.swift
//  Domain
//
//  Created by dgsw8th61 on 2/6/25.
//

import Foundation

public protocol NoticeRepository: RepositoryProtocol {
    
    func fetchNotice(_ request: FetchNoticeRequest) async throws -> [NoticeResponse]
    
    func fetchCategoryNotice(id: Int, _ request: FetchCategoryNoticeRequest) async throws -> [NoticeResponse]
}
