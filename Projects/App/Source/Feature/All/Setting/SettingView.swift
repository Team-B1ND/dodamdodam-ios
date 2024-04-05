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
    
    let data: MemberResponse
    @Flow var flow
    @State var isShowingLogoutAlert: Bool = false
    
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
                        .padding([.leading, .vertical], 8)
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
                            Text("\(student.grade)학년 \(student.room)반 \(student.number)번")
                                .font(.label(.large))
                                .dodamColor(.tertiary)
                        }
                    }
                    Spacer()
                }
                
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
                    Text("1.0.0")
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
                    isShowingLogoutAlert.toggle()
                } label: {
                    HStack(spacing: 16) {
                        Text("로그아웃")
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
            .padding([.top, .horizontal], 16)
        }
        .alert(
            "로그아웃 하시겠습니까?",
            isPresented: $isShowingLogoutAlert
        ) {
            Button("네", role: .destructive) {
                Sign.logout()
                flow.replace([OnboardingView()])
            }
            Button("취소", role: .cancel) { }
        }
    }
}
