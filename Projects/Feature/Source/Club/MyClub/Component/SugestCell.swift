import SwiftUI
import DDS
import Domain
import Shared
import FlowKit

struct SugestCell: View {
    @ObservedObject var viewModel: MyClubViewModel
    @DodamDialog private var dialog
    @Flow var flow
    
    init(for viewModel: MyClubViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text("받은 부원 제안")
                    .font(.headline(.bold))
                    .foreground(DodamColor.Label.normal)
            }
            
            if let joinRequests = viewModel.joinRequests {
                if !joinRequests.isEmpty {
                    VStack(alignment: .leading, spacing: 14) {
                        ForEach(joinRequests, id: \.self) { request in
                            HStack {
                                Text(request.club.name)
                                    .font(.body2(.medium))
                                    .foreground(DodamColor.Label.normal)
                                Spacer()
                                
                                HStack {
                                    Spacer()
                                    
                                    Button {
                                        let dialog = Dialog(title: "\(request.club.name)에 \n입부하시겠습니까?", message: "이 선택은 되돌릴 수 없습니다.")
                                            .primaryButton("수락") {
                                                Task {
                                                    await viewModel.acceptJoinRequest(id: request.id)
                                                }
                                                flow.pop()
                                            }
                                            .secondaryButton("취소") {}
                                        self.dialog.present(dialog)
                                    } label: {
                                        Image(icon: DodamIconography.checkCircle)
                                    }
                                    .padding(.horizontal, 8)
                                    
                                    Button {
                                        let dialog = Dialog(title: "\(request.club.name)에 \n입부하시겠습니까?", message: "이 선택은 되돌릴 수 없습니다.")
                                            .primaryButton("거절") {
                                                Task {
                                                    await viewModel.rejectJoinRequest(id: request.id)
                                                }
                                                flow.pop()
                                            }
                                            .secondaryButton("취소") {}
                                        self.dialog.present(dialog)
                                    } label: {
                                        Image(icon: DodamIconography.redXmarkCircle)
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
            } else {
                DodamLoadingView()
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(DodamColor.Background.normal)
        .clipShape(.medium)
        .padding(16)
    }
}
