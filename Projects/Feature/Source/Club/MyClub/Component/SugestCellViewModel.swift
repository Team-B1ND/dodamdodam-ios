import Foundation
import Domain
import Shared
import DIContainer

final class SugestCellViewModel: ObservableObject {
    
    // MARK: - State
    @Published var joinRequests: [ClubJoinRequestsResponse]?
    
    var isFirstOnAppear: Bool = true
    
    // MARK: - Repository
    @Inject private var clubRepository: ClubRepository
    
    // MARK: - Method
    @MainActor
    func fetchReceivedJoinRequests() async {
        do {
            joinRequests = try await clubRepository.fetchClubJoinRequests()
        } catch let error {
            print(error.localizedDescription)
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
        async let fetchReceivedJoinRequests: () = fetchReceivedJoinRequests()
        _ = await fetchReceivedJoinRequests
    }
}
