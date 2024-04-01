//
//  AllView.swift
//  DodamDodam
//
//  Created by 이민규 on 3/29/24.
//

import SwiftUI
import DDS

struct AllView: View {
    
    @InjectObject var viewModel: AllViewModel
    @Flow var flow
    
    var body: some View {
        DodamScrollView {
            HStack {
                Text("전체")
                    .font(.headline(.small))
                    .dodamColor(.onSurface)
                    .padding(.leading, 20)
                Spacer()
                Button {
                    flow.push(NightStudyApplyView())
                } label: {
                    Dodam.icon(.gear)
                        .resizable()
                        .frame(width: 24, height: 24)
                        .dodamColor(.onSurfaceVariant)
                }
                .frame(width: 44, height: 44)
                .padding(.trailing, 12)
            }
            .frame(height: 58)
            .frame(maxWidth: .infinity)
            .background(.regularMaterial)
        } content: {
            VStack(spacing: 24) {
                HStack(spacing: 16) {
                    if let image = viewModel.memberData?.profileImage {
                        AsyncImage(url: URL(string: image)) { image in
                            image
                                .resizable()
                                .frame(width: 70, height: 70)
                        } placeholder: {
                            Rectangle()
                                .frame(width: 70, height: 70)
                                .shimmer()
                        }
                    } else {
                        Rectangle()
                            .frame(width: 70, height: 70)
                            .shimmer()
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    VStack(alignment: .leading) {
                        Text("환영합니다, \("개발자")님")
                            .font(.body(.large))
                            .dodamColor(.onSurface)
                        Text("환영합니다, \("개발자")님")
                            .font(.label(.large))
                            .dodamColor(.onSurfaceVariant)
                    }
                    Spacer()
                }
                Button {
                    
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
                    viewModel.onTapLogoutButton {
                        flow.replace([OnboardingView()
                            .toast(timeout: 3) {
                                Text("로그아웃을 성공했어요")
                            }]
                        )
                    }
                } label: {
                    HStack(spacing: 16) {
                        ZStack {
                            Rectangle()
                                .dodamFill(.secondary)
                                .frame(width: 32, height: 32)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            Image(icon: .doorOpen)
                                .resizable()
                                .frame(width: 20, height: 20)
                        }
                        .padding(.leading, 8)
                        Text("로그아웃")
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
            }
            .padding([.top, .horizontal], 16)
        }
        .background(Dodam.color(.background))
        .task {
            await viewModel.fetchMemberData()
        }
    }
}

#Preview {
    FlowPreview {
        AllView()
            .navigationBarHidden(true)
    }
}
