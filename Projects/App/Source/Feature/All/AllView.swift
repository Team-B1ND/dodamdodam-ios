//
//  AllView.swift
//  DodamDodam
//
//  Created by 이민규 on 3/29/24.
//

import SwiftUI
import DDS
import CachedAsyncImage

struct AllView: View {
    
    @InjectObject var viewModel: AllViewModel
    @Flow var flow
    
    var body: some View {
        DodamScrollView.default(title: "전체") {
            VStack(spacing: 24) {
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
                Button {
                    flow.push(PointView())
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
                
                Button {
                    flow.push(BusApplyView())
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
                
                Button {
                    flow.push(WakeupSongApplyView())
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
                
                Button {
                    viewModel.isShowingLogoutAlert.toggle()
                } label: {
                    HStack(spacing: 16) {
                        ZStack {
                            Rectangle()
                                .dodamFill(.secondary)
                                .frame(width: 32, height: 32)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            Image(icon: .doorOpen)
                                .resizable()
                                .dodamColor(.onSurface)
                                .frame(width: 20, height: 20)
                        }
                        .padding(.leading, 8)
                        Text("로그아웃")
                            .font(.system(size: 18, weight: .medium))
                            .dodamColor(.error)
                        Spacer()
                        Image(icon: .chevronRight)
                            .resizable()
                            .frame(width: 14, height: 14)
                            .dodamColor(.onSurfaceVariant)
                            .padding(.trailing, 4)
                    }
                }
            }
            .padding([.top, .horizontal], 16)
        }
        .task {
            await viewModel.onAppear()
        }
        .alert(
            "로그아웃",
            isPresented: $viewModel.isShowingLogoutAlert
        ) {
            Button("네", role: .none) {
                viewModel.logout()
                flow.replace([OnboardingView()])
            }
            Button("취소", role: .cancel) { }
        } message: {
            Text("로그아웃 하시겠습니까?")
        }
    }
}

#Preview {
    FlowPreview {
        AllView()
    }
}
