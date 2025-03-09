//
//  AllView.swift
//  DodamDodam
//
//  Created by 이민규 on 3/29/24.
//

import SwiftUI
import DDS
import SignKit
import FlowKit
import Shared

struct AllView: View {
    @DodamDialog private var dialog
    @StateObject var viewModel = AllViewModel()
    @Flow var flow
    @Binding var selection: Int
    
    func showStudentCode() {
        guard let code = viewModel.memberData?.student?.code else { return }
        dialog.present(
            .init(title: "학생코드는 \(code)입니다")
            .primaryButton("복사") {
                UIPasteboard.general.string = code
            }.secondaryButton("닫기")
        )
    }
    
    var body: some View {
        DodamScrollView.default(title: "전체") {
            VStack(spacing: 24) {
                if Sign.isLoggedIn {
                    HStack(spacing: 16) {
                        if let data = viewModel.memberData {
                            DodamAvatar.extraLarge(url: data.profileImage)
                            VStack(alignment: .leading) {
                                Text("환영합니다, \(data.name)님")
                                    .headline(.bold)
                                    .foreground(DodamColor.Label.normal)
                                if let student = data.student {
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
                    .padding(.bottom, 8)
                } else {
                    Button {
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
                    if let role = viewModel.memberData?.role {
                        if role == .parent {
                            AllCell("내 자녀 관리", icon: .smilingFace) {
                                flow.push(ChildrenManageView())
                            }
                            AllCell("그룹", icon: .handshake) {
                                flow.push(DivisionView())
                            }
                        } else {
                            AllCell("내 상벌점 보기", icon: .barChart) {
                                flow.push(PointView())
                            }
                            AllCell("내 학생코드 보기", icon: .creditCard) {
                                showStudentCode()
                            }
                            DodamDivider()
                                .padding(.horizontal, 8)

                            AllCell("귀가 버스 신청하기", icon: .colorfulBus) {
                                flow.push(BusApplyView())
                            }
                            AllCell("외출/외박 확인하기", icon: .tent) {
                                selection = 2
                            }
                            AllCell("기상송 확인하기", icon: .wakeupMegaphone) {
                                flow.push(WakeupSongView())
                            }
                            AllCell("기상송 신청하기", icon: .wakeupNote) {
                                flow.push(WakeupSongView(), animated: false)
                                flow.push(WakeupSongApplyView())
                            }
                            AllCell("동아리", icon: .clubMember) {
                                flow.push(ClubView())
                            }
                            AllCell("그룹", icon: .handshake) {
                                flow.push(DivisionView())
                            }
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
