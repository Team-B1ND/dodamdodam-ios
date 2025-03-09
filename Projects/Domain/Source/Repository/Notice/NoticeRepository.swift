//
//  NoticeRepository.swift
//  Domain
//
//  Created by dgsw8th61 on 2/6/25.
//

import Foundation

public protocol NoticeRepository: RepositoryProtocol {
    
    func fetchNotice(_ request: FetchNoticeRequest) async throws -> [NoticeResponse]
    
    func fetchNoticeByDivision(_ request: FetchNoticeByDivisionRequest) async throws -> [NoticeResponse]
}
