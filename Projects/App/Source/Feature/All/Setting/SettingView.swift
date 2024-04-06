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

struct SettingView: View {
    
    @InjectObject var viewModel: SettingViewModel
    @Flow var flow
    
    let data: MemberResponse
    
    init(
        data: MemberResponse
    ) {
        self.data = data
    }
    
    var body: some View {
        DodamScrollView.medium(title: "설정") {
            VStack(alignment: .leading, spacing: 12) {
                HStack(spacing: 12) {
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
                
                Button {
                    viewModel.isShowingLogoutAlert.toggle()
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
                    viewModel.isShowingDeactivationAlert.toggle()
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
            }
            .padding(.horizontal, 16)
        }
        .alert(
            "로그아웃 하시겠습니까?",
            isPresented: $viewModel.isShowingLogoutAlert
        ) {
            Button("로그아웃", role: .destructive) {
                Sign.logout()
                flow.replace([OnboardingView()])
            }
            Button("취소", role: .cancel) { }
        }
        .alert(
            "정말 탈퇴하시겠습니까?",
            isPresented: $viewModel.isShowingDeactivationAlert
        ) {
            Button("회원탈퇴", role: .destructive) {
                Task {
                    do {
                        try await viewModel.patchDeactivate()
                        Sign.logout()
                        flow.replace([OnboardingView()])
                    } catch {
                        print(error)
                    }
                }
            }
            Button("취소", role: .cancel) { }
        }
    }
}
