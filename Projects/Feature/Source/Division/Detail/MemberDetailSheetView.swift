//
//  MemberDetailSheetView.swift
//  Feature
//
//  Created by dgsw8th61 on 2/5/25.
//

import SwiftUI
import DDS
import Domain

struct MemberDetailSheetView: View {
    @EnvironmentObject private var dialog: DialogProvider
    @ObservedObject private var viewModel: DivisionDetailViewModel
    
    private let member: DivisionMemberResponse
    private let id: Int
    
    init(member: DivisionMemberResponse, id: Int, viewModel: DivisionDetailViewModel) {
        self.member = member
        self.id = id
        self._viewModel = ObservedObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            VStack(alignment: .leading, spacing: 8) {
                Text("\(member.memberName)님 정보")
                    .heading1(.bold)
                    .foreground(DodamColor.Label.normal)
                if let grade = member.grade, let room = member.room, let number = member.number {
                    Text("\(grade)학년 \(room)반 \(number)번")
                        .headline(.medium)
                        .foreground(DodamColor.Label.assistive)
                }
            }
            
            HStack {
                Text("권한 정보")
                    .heading1(.bold)
                    .foreground(DodamColor.Label.normal)
                Spacer()
                
                Menu {
                    Button("승격하기") {
                        Task {
                            if member.permission != .admin {
                                await viewModel.patchMemberPermission(id: id, divisionMemberId: member.id, permission: member.permission == .writer ? .admin : .writer)
                            }
                        }
                    }
                    
                    Button("강등하기") {
                        Task {
                            if member.permission != .reader {
                                await viewModel.patchMemberPermission(id: id, divisionMemberId: member.id, permission: member.permission == .writer ? .reader : .writer)
                            }
                        }
                    }
                } label: {
                    Image(icon: .menu)
                        .resizable()
                        .frame(width: 18, height: 18)
                        .foreground(DodamColor.Label.assistive)
                }
            }
            
            Text(member.role.korean)
                .headline(.medium)
                .foreground(DodamColor.Label.assistive)
                .padding(.top, 8)
            
            DodamButton.medium(
                title: "내보내기"
            ) {
                dialog.present(
                    .init(title: "정말 멤버를 내보내시겠습니까?")
                    .primaryButton("내보내기") {
                        Task {
                            await viewModel.deleteMembers(id: id, idList: [member.id])
                        }
                    }.secondaryButton("취소")
                )
            }
            .role(.assistive)
        }
//        .padding(.top, 37)
        .padding(.horizontal, 16)
    }
}
