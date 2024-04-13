//
//  AllView.swift
//  DodamDodam
//
//  Created by 이민규 on 3/29/24.
//

import SwiftUI
import DDS
import CachedAsyncImage
import SignKit
import FlowKit

struct AllView: View {
    
    @StateObject var viewModel = AllViewModel()
    @Flow var flow
    @Binding var selection: Int
    
    var body: some View {
        DodamScrollView.default(title: "전체") {
            VStack(spacing: 24) {
                if Sign.isLoggedIn {
                    HStack(spacing: 16) {
                        if let data = viewModel.memberData {
                            if let profileImage = data.profileImage {
                                CachedAsyncImage(url: URL(string: profileImage)) {
                                    $0
                                        .resizable()
                                        .frame(width: 70, height: 70)
                                } placeholder: {
                                    Rectangle()
                                        .frame(width: 70, height: 70)
                                        .shimmer()
                                }
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                            } else {
                                Image("Profile")
                                    .resizable()
                                    .frame(width: 70, height: 70)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                            }
                            if let student = data.student {
                                VStack(alignment: .leading) {
                                    Text("환영합니다, \(student.name)님")
                                        .font(.body(.large))
                                        .dodamColor(.onSurface)
                                    Text("\(student.grade)학년 \(student.room)반 \(student.number)번")
                                        .font(.label(.large))
                                        .dodamColor(.onSurfaceVariant)
                                }
                            }
                        } else {
                            Rectangle()
                                .frame(width: 70, height: 70)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .shimmer()
                            VStack(alignment: .leading) {
                                Rectangle()
                                    .frame(width: 150, height: 24)
                                    .shimmer()
                                Rectangle()
                                    .frame(width: 90, height: 16)
                                    .shimmer()
                            }
                        }
                        Spacer()
                    }
                } else {
                    Button {
                        flow.push(LoginView())
                    } label: {
                        HStack(spacing: 16) {
                            Image("Profile")
                                .resizable()
                                .frame(width: 70, height: 70)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                            Text("로그인하세요.")
                                .font(.body(.large))
                                .dodamColor(.onSurface)
                            Spacer()
                        }
                    }
                    .scaledButtonStyle()
                }
                VStack(spacing: 12) {
                    Button {
                        if Sign.isLoggedIn {
                            flow.push(PointView())
                        } else {
                            let alert = Alert(
                                title: "로그인이 필요한 기능입니다",
                                message: "로그인하시겠습니까?",
                                primaryButton: .default("로그인") {
                                    flow.push(LoginView())
                                },
                                secondaryButton: .cancel("취소")
                            )
                            flow.alert(alert)
                        }
                    } label: {
                        HStack(spacing: 16) {
                            ZStack {
                                Rectangle()
                                    .dodamFill(.secondary)
                                    .frame(width: 32, height: 32)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                Image(icon: .barChart)
                                    .resizable()
                                    .frame(width: 20, height: 20)
                            }
                            .padding(.vertical, 4)
                            .padding(.leading, 8)
                            Text("내 상벌점 보기")
                                .font(.system(size: 18, weight: .medium))
                                .dodamColor(.onBackground)
                            Spacer()
                            Image(icon: .chevronRight)
                                .resizable()
                                .frame(width: 14, height: 14)
                                .dodamColor(.onSurfaceVariant)
                                .padding(.trailing, 4)
                        }
                    }
                    .scaledButtonStyle()
                    
                    Rectangle()
                        .dodamFill(.outlineVariant)
                        .frame(maxWidth: .infinity)
                        .frame(height: 1)
                        .padding(.horizontal, 8)
                    
                    Button {
                        if Sign.isLoggedIn {
                            flow.push(BusApplyView())
                        } else {
                            let alert = Alert(
                                title: "로그인이 필요한 기능입니다",
                                message: "로그인하시겠습니까?",
                                primaryButton: .default("로그인") {
                                    flow.push(LoginView())
                                },
                                secondaryButton: .cancel("취소")
                            )
                            flow.alert(alert)
                        }
                    } label: {
                        HStack(spacing: 16) {
                            ZStack {
                                Rectangle()
                                    .dodamFill(.secondary)
                                    .frame(width: 32, height: 32)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                Image(icon: .colorfulBus)
                                    .resizable()
                                    .frame(width: 20, height: 20)
                            }
                            .padding(.vertical, 4)
                            .padding(.leading, 8)
                            Text("귀가 버스 신청하기")
                                .font(.system(size: 18, weight: .medium))
                                .dodamColor(.onBackground)
                            Spacer()
                            Image(icon: .chevronRight)
                                .resizable()
                                .frame(width: 14, height: 14)
                                .dodamColor(.onSurfaceVariant)
                                .padding(.trailing, 4)
                        }
                    }
                    .scaledButtonStyle()
                    
                    Button {
                        selection = 2
                    } label: {
                        HStack(spacing: 16) {
                            ZStack {
                                Rectangle()
                                    .dodamFill(.secondary)
                                    .frame(width: 32, height: 32)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                Image(icon: .tent)
                                    .resizable()
                                    .frame(width: 20, height: 20)
                            }
                            .padding(.vertical, 4)
                            .padding(.leading, 8)
                            Text("외출/외박 확인하기")
                                .font(.system(size: 18, weight: .medium))
                                .dodamColor(.onBackground)
                            Spacer()
                            Image(icon: .chevronRight)
                                .resizable()
                                .frame(width: 14, height: 14)
                                .dodamColor(.onSurfaceVariant)
                                .padding(.trailing, 4)
                        }
                    }
                    .scaledButtonStyle()
                    
                    Button {
                        flow.push(WakeupSongView())
                    } label: {
                        HStack(spacing: 16) {
                            ZStack {
                                Rectangle()
                                    .dodamFill(.secondary)
                                    .frame(width: 32, height: 32)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                Image(icon: .wakeupMegaphone)
                                    .resizable()
                                    .frame(width: 20, height: 20)
                            }
                            .padding(.vertical, 4)
                            .padding(.leading, 8)
                            Text("기상송 확인하기")
                                .font(.system(size: 18, weight: .medium))
                                .dodamColor(.onBackground)
                            Spacer()
                            Image(icon: .chevronRight)
                                .resizable()
                                .frame(width: 14, height: 14)
                                .dodamColor(.onSurfaceVariant)
                                .padding(.trailing, 4)
                        }
                    }
                    .scaledButtonStyle()
                    
                    Button {
                        if Sign.isLoggedIn {
                            flow.push(WakeupSongView(), animated: false)
                            flow.push(WakeupSongApplyView())
                        } else {
                            let alert = Alert(
                                title: "로그인이 필요한 기능입니다",
                                message: "로그인하시겠습니까?",
                                primaryButton: .default("로그인") {
                                    flow.push(LoginView())
                                },
                                secondaryButton: .cancel("취소")
                            )
                            flow.alert(alert)
                        }
                    } label: {
                        HStack(spacing: 16) {
                            ZStack {
                                Rectangle()
                                    .dodamFill(.secondary)
                                    .frame(width: 32, height: 32)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                Image(icon: .wakeupNote)
                                    .resizable()
                                    .frame(width: 20, height: 20)
                            }
                            .padding(.vertical, 4)
                            .padding(.leading, 8)
                            Text("기상송 신청하기")
                                .font(.system(size: 18, weight: .medium))
                                .dodamColor(.onBackground)
                            Spacer()
                            Image(icon: .chevronRight)
                                .resizable()
                                .frame(width: 14, height: 14)
                                .dodamColor(.onSurfaceVariant)
                                .padding(.trailing, 4)
                        }
                    }
                    .scaledButtonStyle()
                }
            }
            .padding([.top, .horizontal], 16)
        }
        .button(icon: .gear) {
            flow.push(SettingView())
        }
        .task {
            await viewModel.onAppear()
        }
        .refreshable {
            await viewModel.onRefresh()
        }
    }
}

#Preview {
    FlowPreview {
        AllView(selection: .constant(4))
    }
}
