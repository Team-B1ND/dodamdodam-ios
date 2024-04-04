//
//  NightStudyDataSource.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

struct NightStudyDataSource: DataSourceProtocol {
    
    let remote: NightStudyRemote
    
    func postNightStudy(_ request: PostNightStudyRequest) async throws {
        _ = try await remote.postNightStudy(request)
    }
    
    func deleteNightStudy(id: Int) async throws {
        _ = try await remote.deleteNightStudy(id: id)
    }
    
    func fetchNightStudy() async throws -> [NightStudyResponse] {
        let response = try await remote.fetchNightStudy()
        return response.data
    }
}
