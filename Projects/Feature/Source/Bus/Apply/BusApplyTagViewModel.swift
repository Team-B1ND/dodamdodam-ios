//
//  BusApplyTagViewModel.swift
//  Feature
//
//  Created by hhhello0507 on 3/10/25.
//

import Foundation
import Domain
import DIContainer

struct R: Encodable {
    let memberId: String
    let nonce: String
}

final class BusApplyTagViewModel: ObservableObject {
    
    // MARK: - State
    @Published var nonce: String?
    var isFirstOnAppear: Bool = true
    private let busId: Int
    
    // MARK: - Repository
    @Inject var busRepository: any BusRepository
    
    // MARK: - Method
    init(busId: Int) {
        self.busId = busId
    }
    
    @MainActor
    func fetchNonce() async {
        do {
            let response = try await busRepository.fetchQrCode()
            nonce = response.nonce
        } catch {
            print(error)
        }
        
//        nonce = "123"
        if let data = try? JSONEncoder().encode(R(memberId: "멤버아이디", nonce: "논스")) {
            let json = String(decoding: data, as: UTF8.self)
            nonce = json
        }
    }
}

extension BusApplyTagViewModel: OnAppearProtocol {
    @MainActor
    func fetchAllData() async {
        await fetchNonce()
    }
}
