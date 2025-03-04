//
//  ClubApplyView 2.swift
//  Feature
//
//  Created by dgsw01 on 3/4/25.
//


import SwiftUI
import DDS
import Shared
import Domain

struct ClubApplyView: View {
    @StateObject private var viewModel: ClubApplyViewModel
    @State private var selection: Int = 0
    
    init() {
        // 실제 ClubRepository 의존성 주입
        let repository = DependencyProvider.shared.container.resolve(ClubRepository.self)!
        _viewModel = StateObject(wrappedValue: ClubApplyViewModel(clubRepository: repository))
    }
    
    var body: some View {
        DodamScrollView.medium(title: "동아리 신청") {
            if viewModel.isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.vertical, 100)
            } else if selection == 0 {
                // 창체 동아리 화면
                VStack(spacing: 16) {
                    ForEach(viewModel.creativeSelections.indices, id: \.self) { index in
                        VStack(alignment: .leading, spacing: 4) {
                            Menu {
                                ForEach(viewModel.creativeClubs, id: \.id) { club in
                                    Button {
                                        viewModel.creativeSelections[index].club = club
                                    } label: {
                                        Text(club.name)
                                    }
                                    .disabled(viewModel.creativeSelections.contains { $0.club?.id == club.id })
                                }
                            } label: {
                                HStack {
                                    Text("\(index + 1)순위:")
                                        .foreground(DodamColor.Label.normal)
                                        .font(.headline(.bold))
                                    
                                    Text(viewModel.creativeSelections[index].club?.name ?? "동아리 선택")
                                    
                                    Image(systemName: "chevron.up.chevron.down")
                                }
                            }
                            
                            DodamTextField.editor(
                                title: "자기소개",
                                text: Binding(
                                    get: { viewModel.creativeSelections[index].text },
                                    set: { viewModel.creativeSelections[index].text = $0 }
                                )
                            )
                            .font(.body1(.medium))
                            .foreground(DodamColor.Label.normal)
                            .frame(height: 300)
                            Spacer()
                        }
                        .padding(16)
                        .frame(maxWidth: .infinity)
                        .frame(height: 363)
                        .background(DodamColor.Background.normal)
                        .clipShape(.medium)
                    }
                }
                .padding()
            } else if selection == 1 {
                // 자율 동아리 화면
                VStack(spacing: 16) {
                    ForEach(viewModel.freeSelections.indices, id: \.self) { index in
                        VStack(alignment: .leading, spacing: 4) {
                            Menu {
                                ForEach(viewModel.freeClubs, id: \.id) { club in
                                    Button {
                                        viewModel.freeSelections[index].club = club
                                    } label: {
                                        Text(club.name)
                                    }
                                    .disabled(viewModel.freeSelections.contains { $0.club?.id == club.id })
                                }
                            } label: {
                                HStack {
                                    Text("자율동아리:")
                                        .foreground(DodamColor.Label.normal)
                                        .font(.headline(.bold))
                                    
                                    Text(viewModel.freeSelections[index].club?.name ?? "동아리 선택")
                                    
                                    Image(systemName: "chevron.up.chevron.down")
                                }
                            }
                            
                            DodamTextField.editor(
                                title: "자기소개",
                                text: Binding(
                                    get: { viewModel.freeSelections[index].text },
                                    set: { viewModel.freeSelections[index].text = $0 }
                                )
                            )
                            .font(.body1(.medium))
                            .foreground(DodamColor.Label.normal)
                            .frame(height: 300)
                            Spacer()
                        }
                        .padding(16)
                        .frame(maxWidth: .infinity)
                        .frame(height: 363)
                        .background(DodamColor.Background.normal)
                        .clipShape(.medium)
                        
                        if index == viewModel.freeSelections.count - 1 && viewModel.freeSelections.count < viewModel.freeClubs.count {
                            Button {
                                viewModel.addFreeSelection()
                            } label: {
                                VStack(alignment: .center) {
                                    Image(icon: .plus)
                                        .resizable()
                                        .frame(width: 28, height: 28)
                                        .foreground(DodamColor.Label.alternative)
                                        .padding(.vertical)
                                }
                                .frame(maxWidth: .infinity)
                                .background(DodamColor.Background.normal)
                                .clipShape(.medium)
                            }
                        }
                    }
                }
                .padding()
            }
        }
        .subView {
            DodamSegmentedButton(
                labels: ["창체", "자율"],
                selection: $selection
            )
        }
        .overlay(alignment: .bottom) {
            DodamButton.fullWidth(
                title: "동아리 입부 신청하기"
            ) {
                Task {
                    await viewModel.applyToClub()
                }
            }
            .padding([.bottom, .horizontal], 16)
        }
        .ignoresSafeArea(.keyboard)
        .background(DodamColor.Background.neutral)
        .hideKeyboardWhenTap()
        .task {
            // 페이지 로드시 동아리 목록 가져오기
            await viewModel.fetchClubs()
        }
        .alert(isPresented: $viewModel.showAlert) {
            if let successMessage = viewModel.successMessage {
                return Alert(
                    title: Text("성공"),
                    message: Text(successMessage),
                    dismissButton: .default(Text("확인"))
                )
            } else {
                return Alert(
                    title: Text("오류"),
                    message: Text(viewModel.errorMessage ?? "알 수 없는 오류가 발생했습니다."),
                    dismissButton: .default(Text("확인"))
                )
            }
        }
    }
}

#Preview {
    ClubApplyView()
}