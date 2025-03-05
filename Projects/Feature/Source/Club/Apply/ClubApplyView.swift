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

struct ClubApplyView: View {
    @StateObject private var viewModel = ClubApplyViewModel()
    @State private var selection: Int = 0
    
    var body: some View {
        DodamScrollView.medium(title: "동아리 신청") {
            if selection == 0 {
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
            await viewModel.fetchClubs()
        }
    }
}

#Preview {
    ClubApplyView()
}
