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

struct SettingView: View {
    
    @StateObject var viewModel = SettingViewModel()
    @Flow var flow
    
    var body: some View {
        DodamScrollView.medium(title: "설정") {
            VStack(alignment: .leading, spacing: 12) {
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
                                    .font(.body(.large))
                                    .dodamColor(.onBackground)
                                Text("정보 수정은 곧 추가됩니다")
                                    .font(.label(.large))
                                    .dodamColor(.tertiary)
                            }
                        }
                        Spacer()
                    }
                }
                .padding([.leading, .vertical], 8)
                
                Rectangle()
                    .dodamFill(.outlineVariant)
                    .frame(maxWidth: .infinity)
                    .frame(height: 1)
                    .padding(.horizontal, 8)
                
                Button {
                    guard let url = URL(
                        string: "https://dodam.b1nd.com/detailed-information/service-policy"
                    ) else { return }
                    UIApplication.shared.open(url)
                } label: {
                    HStack(spacing: 16) {
                        Text("서비스 운영 정책")
                            .font(.system(size: 18, weight: .medium))
                            .dodamColor(.onBackground)
                        Spacer()
                        Image(icon: .chevronRight)
                            .resizable()
                            .frame(width: 14, height: 14)
                            .dodamColor(.onSurfaceVariant)
                    }
                    .padding(8)
                }
                .scaledButtonStyle()
                
                Button {
                    guard let url = URL(
                        string: "https://dodam.b1nd.com/detailed-information/personal-information"
                    ) else { return }
                    UIApplication.shared.open(url)
                } label: {
                    HStack(spacing: 16) {
                        Text("개인정보 처리 방침")
                            .font(.system(size: 18, weight: .medium))
                            .dodamColor(.onBackground)
                        Spacer()
                        Image(icon: .chevronRight)
                            .resizable()
                            .frame(width: 14, height: 14)
                            .dodamColor(.onSurfaceVariant)
                    }
                    .padding(8)
                }
                .scaledButtonStyle()
                
                HStack(spacing: 16) {
                    Text("버전 정보")
                        .font(.system(size: 18, weight: .medium))
                        .dodamColor(.onBackground)
                    Spacer()
                    Text("\(getAppVersion())")
                        .font(.system(size: 18, weight: .regular))
                        .dodamColor(.tertiary)
                }
                .padding(8)
                
                Rectangle()
                    .dodamFill(.outlineVariant)
                    .frame(maxWidth: .infinity)
                    .frame(height: 1)
                    .padding(.horizontal, 8)
                if Sign.isLoggedIn {
                    Button {
                        let alert = Alert(
                            title: "로그아웃 하시겠습니까?",
                            primaryButton: .destructive("로그아웃") {
                                Sign.logout()
                                flow.replace([MainView()])
                            },
                            secondaryButton: .cancel("취소")
                        )
                        flow.alert(alert)
                    } label: {
                        HStack(spacing: 16) {
                            Text("로그아웃")
                                .font(.system(size: 18, weight: .medium))
                                .dodamColor(.onSurface)
                            Spacer()
                            Image(icon: .chevronRight)
                                .resizable()
                                .frame(width: 14, height: 14)
                                .dodamColor(.onSurfaceVariant)
                        }
                        .padding(8)
                    }
                    .scaledButtonStyle()
                    Button {
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
                    } label: {
                        HStack(spacing: 16) {
                            Text("회원탈퇴")
                                .font(.system(size: 18, weight: .medium))
                                .dodamColor(.error)
                            Spacer()
                            Image(icon: .chevronRight)
                                .resizable()
                                .frame(width: 14, height: 14)
                                .dodamColor(.onSurfaceVariant)
                        }
                        .padding(8)
                    }
                    .scaledButtonStyle()
                } else {
                    Button {
                        flow.push(LoginView())
                    } label: {
                        HStack(spacing: 16) {
                            Text("로그인")
                                .font(.system(size: 18, weight: .medium))
                            Spacer()
                            Image(icon: .chevronRight)
                                .resizable()
                                .frame(width: 14, height: 14)
                                .dodamColor(.onSurfaceVariant)
                        }
                        .padding(8)
                    }
                    .scaledButtonStyle()
                    Button {
                        flow.push(RegisterInfoView())
                    } label: {
                        HStack(spacing: 16) {
                            Text("회원가입")
                                .font(.system(size: 18, weight: .medium))
                            Spacer()
                            Image(icon: .chevronRight)
                                .resizable()
                                .frame(width: 14, height: 14)
                                .dodamColor(.onSurfaceVariant)
                        }
                        .padding(8)
                    }
                    .scaledButtonStyle()
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
