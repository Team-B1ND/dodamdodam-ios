//
//  ApplyView.swift
//  Feature
//
//  Created by dgsw30 on 2/20/25.
//

import SwiftUI
import DDS
import Shared
import Domain
import DIContainer
import FlowKit

struct ClubApplyView: View {
    @StateObject private var viewModel = ClubApplyViewModel()
    @State private var selection: Int = 0
    @DodamDialog private var dialog
    @Flow var flow
    
    private var isValidDivisionDescription: Bool {
        viewModel.freeSelections.contains(where: { $0.text.count <= 300 })
    }
    
    var body: some View {
        DodamScrollView.medium(title: "동아리 신청") {
            if selection == 0 {
                VStack(spacing: 16) {
                    ForEach(viewModel.activitySelections.indices, id: \.self) { index in
                        VStack {
                            let activityClubs = viewModel.activityClubs.filter({ $0.state == .allowed })
                            if !activityClubs.isEmpty {
                                Menu {
                                    ForEach(activityClubs, id: \.id) { club in
                                        let isClubSelected = viewModel.activitySelections.contains { $0?.id == club.id }
                                        Button {
                                            viewModel.activitySelections[index] = club
                                        } label: {
                                            Text(club.name)
                                        }
                                        .disabled(isClubSelected)
                                    }
                                } label: {
                                    HStack {
                                        Text("\(index + 1)순위:")
                                            .foreground(DodamColor.Label.normal)
                                            .font(.headline(.bold))
                                        
                                        Text(viewModel.activitySelections[index]?.name ?? "동아리 선택")
                                        
                                        Image(systemName: "chevron.up.chevron.down")
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(12)
                                    .padding(.horizontal, 6)
                                }
                            } else {
                                DodamLoadingView()
                                    .frame(maxWidth: .infinity, alignment: .center)
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: 191)
                .background(DodamColor.Background.normal)
                .clipShape(.medium)
                .padding(16)
                
            } else if selection == 1 {
                VStack(spacing: 16) {
                    ForEach(viewModel.freeSelections.indices, id: \.self) { index in
                        VStack(alignment: .leading, spacing: 4) {
                            let freeClubs = viewModel.freeClubs.filter { $0.state == .allowed }
                            if !freeClubs.isEmpty {
                                Menu {
                                    ForEach(freeClubs, id: \.id) { club in
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
                            
                            HStack(spacing: 0) {
                                Spacer()
                                Text("\(viewModel.freeSelections[index].text.count)")
                                    .font(.body1(.medium))
                                    .foreground(
                                        isValidDivisionDescription
                                        ? DodamColor.Primary.normal
                                        : DodamColor.Status.negative
                                    )
                                Text("/300")
                                    .font(.body1(.medium))
                                    .foreground(
                                        isValidDivisionDescription
                                        ? DodamColor.Label.assistive
                                        : DodamColor.Status.negative
                                    )
                            }
                        }
                        .padding(16)
                        .frame(maxWidth: .infinity)
                        .frame(height: 383)
                        .background(DodamColor.Background.normal)
                        .clipShape(.medium)
                        
                        let freeClubs = viewModel.freeClubs.filter { $0.state == .allowed }
                        if index == viewModel.freeSelections.count - 1 && viewModel.freeSelections.count < freeClubs.count {
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
            } else {
                DodamLoadingView()
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
                let isFreeSelectionEmpty = viewModel.freeSelections.contains(where: { $0.text.isEmpty || $0.club == nil })
                
                let lastDialog = Dialog(title: "정말 확실합니까?", message: "창체동아리: \n\(viewModel.activityMessage) \n 위동아리로 신청을 넣겠습니까?")
                    .primaryButton("신청하기") {
                        Task {
                            await viewModel.applyToClub()
                        }
                        flow.pop()
                    }
                    .secondaryButton("취소") {}
                
                let dialog: Dialog
                
                if isFreeSelectionEmpty {
                    dialog = Dialog(
                        title: "정말 확실합니까?",
                        message: "자율동아리 신청이 비었어요. \n창체만 신청 하시겠습니까?"
                    )
                    .primaryButton("네") {
                        Task {
                            try? await Task.sleep(seconds: 0.3)
                            self.dialog.present(lastDialog)
                        }
                    }
                    .secondaryButton("취소") {}
                } else {
                    dialog = Dialog(title: "정말 확실합니까?", message: "창체동아리: \n\(viewModel.activityMessage) \n자율동아리: \n\(viewModel.freeClubsMessage) \n위동아리로 신청을 넣겠습니까?")
                        .primaryButton("신청하기") {
                            Task {
                                await viewModel.applyToClub()
                            }
                            flow.pop()
                        }
                        .secondaryButton("취소") {}
                }
                self.dialog.present(dialog)
            }
            .disabled(
                !viewModel.activitySelections.allSatisfy { $0 != nil } ||
                (selection == 1 && (!isValidDivisionDescription ||
                !viewModel.freeSelections.allSatisfy { $0.club != nil && !$0.text.isEmpty }))
            )
            .padding([.bottom, .horizontal], 16)
        }
        .ignoresSafeArea(.keyboard)
        .background(DodamColor.Background.neutral)
        .hideKeyboardWhenTap()
        .task {
            await viewModel.onAppear()
            
            let emptyActivityClubs = viewModel.activityClubs.filter { $0.state == .allowed }.isEmpty
            let emptyActivityClubsFreeClubs = viewModel.freeClubs.filter { $0.state == .allowed }.isEmpty
            if emptyActivityClubs && emptyActivityClubsFreeClubs {
                let alertDialog = Dialog(
                    title: "동아리 없음",
                    message: "현재 신청 가능한 동아리가 없습니다."
                )
                    .primaryButton("확인") {
                        flow.pop()
                    }
                
                self.dialog.present(alertDialog)
            }
        }
    }
}

#Preview {
    ClubApplyView()
}
