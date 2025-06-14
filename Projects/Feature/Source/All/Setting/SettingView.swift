//
//  SettingView.swift
//  DodamDodam
//
//  Created by 이민규 on 4/5/24.
//

import SwiftUI
import DDS
import SignKit
import FlowKit
import Shared

struct SettingView: View {
    
    @DodamDialog private var dialog
    @StateObject var viewModel = SettingViewModel()
    @Flow var flow
    
    var body: some View {
        DodamScrollView.medium(title: "설정") {
            VStack(alignment: .leading, spacing: 12) {
                if Sign.isLoggedIn {
                    HStack(spacing: 12) {
                        if let data = viewModel.memberData {
                            DodamAvatar.extraLarge(url: data.profileImage)
                            VStack(alignment: .leading) {
                                Text("\(data.name)")
                                    .headline(.bold)
                                    .foreground(DodamColor.Label.normal)
                                Button {
                                    flow.push(EditMemberInfoView(memberData: data))
                                } label: {
                                    Text("정보 수정")
                                        .underline()
                                        .label(.medium)
                                        .foreground(DodamColor.Label.alternative)
                                }
                            }
                            Spacer()
                        } else {
                            Rectangle()
                                .frame(width: 48, height: 48)
                                .shimmer()
                                .clipShape(.extraSmall)
                            VStack(alignment: .leading) {
                                Rectangle()
                                    .frame(width: 80, height: 24)
                                    .shimmer()
                                Rectangle()
                                    .frame(width: 240, height: 20)
                                    .shimmer()
                            }
                        }
                    }
                    .padding(.bottom, 8)
                    DodamDivider()
                        .padding(.horizontal, 8)
                }
                SettingCell.link("서비스 운영 정책", link: URL(string: "https://dodam.b1nd.com/detailed-information/service-policy")!)
                SettingCell.link("개인정보 처리 방침", link: URL(string: "https://dodam.b1nd.com/detailed-information/personal-information")!)
                SettingCell.description("버전 정보", description: "\(getAppVersion())")
                DodamDivider()
                    .padding(.horizontal, 8)
                if Sign.isLoggedIn {
                    SettingCell.action("로그아웃") {
                        let dialog = Dialog(title: "로그아웃 하시겠습니까?")
                            .primaryButton("로그아웃") {
                                Sign.logout()
                                flow.replace([MainView()])
                            }
                            .secondaryButton("취소")
                        self.dialog.present(dialog)
                    }
                    SettingCell.action("회원탈퇴") {
                        let lastDialog = Dialog(title: "정말 정말 정말 탈퇴하시겠습니까?", message: "회원 탈퇴 시 모든 정보가 삭제됩니다!!!!!!")
                            .primaryButton("회원 탈퇴") {
                                Task {
                                    try await viewModel.patchDeactivate()
                                    Sign.logout()
                                    flow.replace([MainView()])
                                }
                            }
                            .secondaryButton("취소")
                        let secondDialog = Dialog(title: "정말 정말 탈퇴하시겠습니까?", message: "회원 탈퇴 시 모든 정보가 삭제됩니다")
                            .primaryButton("회원 탈퇴") {
                                Task {
                                    try? await Task.sleep(seconds: 0.3)
                                    dialog.present(lastDialog)
                                }
                            }
                            .secondaryButton("취소")
                        
                        let firstDialog = Dialog(title: "정말 탈퇴하시겠습니까")
                            .primaryButton("회원탈퇴") {
                                Task {
                                    try? await Task.sleep(seconds: 0.3)
                                    dialog.present(secondDialog)
                                }
                            }
                            .secondaryButton("취소")
                        dialog.present(firstDialog)
                    }
                    .destructive()
                } else {
                    SettingCell.action("로그인") {
                        flow.push(LoginView())
                    }
                }
            }
            .padding(.horizontal, 16)
            .task {
                await viewModel.onAppear()
            }
            .refreshable {
                await viewModel.onRefresh()
            }
        }
    }
}
