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
import Shared

struct AllView: View {
    @DodamDialog private var dialog
    @StateObject var viewModel = AllViewModel()
    @Flow var flow
    @Binding var selection: Int
    
    private func presentLoginDialog() {
        dialog.present(
            .init(title: "로그인이 필요한 기능입니다", message: "로그인 하시겠습니까")
            .primaryButton("로그인") {
                flow.push(LoginView())
            }
            .secondaryButton("취소") {}
        )
    }
    
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
                                .clipShape(.medium)
                            } else {
                                Image("Profile")
                                    .resizable()
                                    .frame(width: 70, height: 70)
                                    .clipShape(.medium)
                            }
                            if let student = data.student {
                                VStack(alignment: .leading) {
                                    Text("환영합니다, \(student.name)님")
                                        .headline(.bold)
                                        .foreground(DodamColor.Label.normal)
                                    Text("\(student.grade)학년 \(student.room)반 \(student.number)번")
                                        .label(.medium)
                                        .foreground(DodamColor.Label.alternative)
                                }
                            }
                        } else {
                            Rectangle()
                                .frame(width: 70, height: 70)
                                .clipShape(.medium)
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
                        dump(flow)
                        flow.push(LoginView())
                    } label: {
                        HStack(spacing: 16) {
                            Image("Profile")
                                .resizable()
                                .frame(width: 70, height: 70)
                                .clipShape(.medium)
                            Text("로그인하세요.")
                                .headline(.bold)
                                .foreground(DodamColor.Label.normal)
                            Spacer()
                        }
                    }
                    .scaledButtonStyle()
                }
                VStack(spacing: 12) {
                    AllCell("내 상벌점 보기", icon: .barChart) {
                        if Sign.isLoggedIn {
                            flow.push(PointView())
                        } else {
                            presentLoginDialog()
                        }
                    }
                    DodamDivider()
                        .padding(.horizontal, 8)
                    
                    AllCell("귀가 버스 신청하기", icon: .colorfulBus) {
                        if Sign.isLoggedIn {
                            flow.push(BusApplyView())
                        } else {
                            presentLoginDialog()
                        }
                    }
                    AllCell("외출/외박 확인하기", icon: .tent) {
                        selection = 2
                    }
                    AllCell("기상송 확인하기", icon: .wakeupMegaphone) {
                        flow.push(WakeupSongView())
                    }
                    AllCell("기상송 신청하기", icon: .wakeupNote) {
                        if Sign.isLoggedIn {
                            flow.push(WakeupSongView(), animated: false)
                            flow.push(WakeupSongApplyView())
                        } else {
                            presentLoginDialog()
                        }
                    }
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
