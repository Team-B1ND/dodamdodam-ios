import SwiftUI
import DIContainer
import DDS
import Domain

struct SugestCell: View {
    @StateObject private var viewModel: SugestCellViewModel
    
    init() {
        let repository: any ClubRepository = Inject<any ClubRepository>().wrappedValue
        _viewModel = StateObject(wrappedValue: SugestCellViewModel(clubRepository: repository))
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text("받은 부원 제안")
                    .font(.headline(.bold))
                    .foreground(DodamColor.Label.normal)
            }
            
            if viewModel.joinRequests == nil {
                HStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
                .padding(.vertical, 20)
            } else if let joinRequests = viewModel.joinRequests, !joinRequests.isEmpty {
                VStack(alignment: .leading, spacing: 14) {
                    ForEach(joinRequests, id: \.id) { request in
                        HStack {
                            Text(request.club.name)
                                .font(.body2(.medium))
                                .foreground(DodamColor.Label.normal)
                            Spacer()
                            
                            HStack {
                                Spacer()
                                
                                Button {
                                    Task {
                                        await viewModel.acceptJoinRequest(id: request.id)
                                    }
                                } label: {
                                    Image(icon: DodamIconography.checkCircle)
                                }
                                .padding(.horizontal, 8)
                                
                                Button {
                                    Task {
                                        await viewModel.rejectJoinRequest(id: request.id)
                                    }
                                } label: {
                                    Image(icon: DodamIconography.xmarkCircle)
                                }
                                .padding(.horizontal, 8)
                            }
                        }
                        
                        if request.id != joinRequests.last?.id {
                            Divider()
                                .padding(.vertical, 4)
                        }
                    }
                }
                .padding(.vertical, 4)
            } else {
                Text("받은 부원 제안이 없습니다")
                    .font(.body2(.regular))
                    .foreground(DodamColor.Label.alternative)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.vertical, 12)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(DodamColor.Background.normal)
        .clipShape(.medium)
        .padding(16)
        .task {
            if viewModel.isFirstOnAppear {
                viewModel.isFirstOnAppear = false
                await viewModel.fetchAllData()
            }
        }
    }
}
