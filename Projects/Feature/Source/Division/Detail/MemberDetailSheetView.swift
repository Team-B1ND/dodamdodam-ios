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
    @EnvironmentObject private var viewModel: DivisionDetailViewModel
    
    private let member: DivisionMemberResponse
    private let id: Int
    
    init(member: DivisionMemberResponse, id: Int) {
        self.member = member
        self.id = id
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text("\(member.memberName)님 정보")
                .heading1(.bold)
                .foreground(DodamColor.Label.normal)
            
            Text("\(member.grade ?? 0)학년 \(member.room ?? 0)반 \(member.number ?? 0)번")
                .headline(.medium)
                .foreground(DodamColor.Label.assistive)
                .padding(.top, 8)
            
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
            .padding(.top, 24)
            
            Text(member.role.rawValue)
                .headline(.medium)
                .foreground(DodamColor.Label.assistive)
                .padding(.top, 8)
            
            DodamButton.medium(
                title: "내보내기"
            ) {
                await viewModel.deleteMembers(id: id, idList: [member.id])
            }
            .role(.assistive)
            .padding(.top, 24)
            
            Spacer()
        }
        .padding(.top, 37)
        .padding(.horizontal, 16)
    }
}
