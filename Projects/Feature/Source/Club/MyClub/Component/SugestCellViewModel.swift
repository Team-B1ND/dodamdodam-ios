import Foundation
import Domain
import Shared

final class SugestCellViewModel: ObservableObject {
    
    // MARK: - State
    @Published var joinRequests: [ClubJoinRequestsResponse]?
    
    var isFirstOnAppear: Bool = true
    
    // MARK: - Repository
    private let clubRepository: any ClubRepository
    
    // MARK: - Init
    init(clubRepository: any ClubRepository) {
        self.clubRepository = clubRepository
    }
    
    // MARK: - Method
    @MainActor
    func fetchReceivedJoinRequests() async {
        print("받은 부원 제안 불러왔음")
        do {
            let result = try await clubRepository.fetchClubJoinRequests()
            print("받은 부원 제안 불러오기 성공 \(result.count)개")
            joinRequests = result
        } catch let error {
            print("받은 부원 제안 불러오기 실패: \(error)")
        }
    }
    
    @MainActor
    func acceptJoinRequest(id: Int) async {
        do {
            _ = try await clubRepository.acceptJoinRequest(id: id)
            await fetchReceivedJoinRequests()
        } catch let error {
            print(error)
        }
    }
    
    @MainActor
    func rejectJoinRequest(id: Int) async {
        do {
            _ = try await clubRepository.rejectJoinRequest(id: id)
            await fetchReceivedJoinRequests()
        } catch let error {
            print(error)
        }
    }
    
    @MainActor
    func clearData() {
        joinRequests = nil
    }
    
    @MainActor
    func onRefresh() async {
        clearData()
        await fetchAllData()
    }
}

extension SugestCellViewModel: OnAppearProtocol {
    @MainActor
    func fetchAllData() async {
        await fetchReceivedJoinRequests()
    }
}
