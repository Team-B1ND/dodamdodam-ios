//
//  SettingView.swift
//  DodamDodam
//
//  Created by 이민규 on 4/5/24.
//

import SwiftUI
import DDS
import CachedAsyncImage
import SignKit
import FlowKit
import Shared

struct SettingView: View {
    
    @StateObject var viewModel = SettingViewModel()
    @Shared.Flow var flow
    
    var body: some View {
        DodamScrollView.medium(title: "설정") {
            VStack(alignment: .leading, spacing: 12) {
                if Sign.isLoggedIn {
                    HStack(spacing: 12) {
                        if let data = viewModel.memberData {
                            if let profileImage = data.profileImage {
                                CachedAsyncImage(url: URL(string: profileImage)) {
                                    $0
                                        .resizable()
                                        .frame(width: 48, height: 48)
                                } placeholder: {
                                    Rectangle()
                                        .frame(width: 48, height: 48)
                                        .shimmer()
                                }
                                .clipShape(RoundedRectangle(cornerRadius: 48))
                            } else {
                                Image("Profile")
                                    .resizable()
                                    .frame(width: 48, height: 48)
                                    .clipShape(RoundedRectangle(cornerRadius: 48))
                            }
                            if let student = data.student {
                                VStack(alignment: .leading) {
                                    Text("\(student.name)")
                                        .headline(.bold)
                                        .foreground(DodamColor.Label.normal)
                                    Text("정보 수정은 곧 추가됩니다")
                                        .label(.medium)
                                        .foreground(DodamColor.Label.alternative)
                                }
                            }
                            Spacer()
                        } else {
                            Rectangle()
                                .frame(width: 48, height: 48)
                                .shimmer()
                                .clipShape(RoundedRectangle(cornerRadius: 8))
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
                    .padding([.leading, .vertical], 8)
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
                        let alert = Alert(
                            title: "로그아웃 하시겠습니까?",
                            primaryButton: .destructive("로그아웃") {
                                Sign.logout()
                                flow.replace([MainView()])
                            },
                            secondaryButton: .cancel("취소")
                        )
                        flow.alert(alert)
                    }
                    SettingCell.action("회원탈퇴") {
                        let alert = Alert(
                            title: "정말 탈퇴하시겠습니까?",
                            primaryButton: .destructive("회원탈퇴") {
                                Task {
                                    do {
                                        try await viewModel.patchDeactivate()
                                        Sign.logout()
                                        flow.replace([MainView()])
                                    } catch {
                                        print(error)
                                    }
                                }
                            },
                            secondaryButton: .cancel("취소")
                        )
                        flow.alert(alert)
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
