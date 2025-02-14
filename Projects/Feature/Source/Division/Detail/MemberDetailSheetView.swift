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
    let member: DivisionMemberResponse
    let id: Int
    @StateObject private var viewModel = DivisionDetailViewModel()

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
                
                Menu(content: {
                    Button(action: {
                        Task {
                            if member.permission != .admin {
                                await viewModel.patchMemberPermission(id: id, divisionMemberId: member.id, permission: member.permission == .writer ? .admin : .writer)
                            }
                        }
                    }, label: {
                        Text("승격하기")
                    })
                    
                    Button(action: {
                        Task {
                            if member.permission != .reader {
                                await viewModel.patchMemberPermission(id: id, divisionMemberId: member.id, permission: member.permission == .writer ? .reader : .writer)
                            }
                        }
                    }, label: {
                        Text("강등하기")
                    })
                }, label: {
                    Image(icon: .menu)
                        .resizable()
                        .frame(width: 18, height: 18)
                        .foreground(DodamColor.Label.assistive)
                })
            }
            .padding(.top, 24)
            
            Text(member.permission.rawValue)
                .headline(.medium)
                .foreground(DodamColor.Label.assistive)
                .padding(.top, 8)
            
            Button {
                Task {
                    await viewModel.deleteMembers(id: id, idList: [member.id])
                }
            } label: {
                Text("내보내기")
                    .body2(.bold)
                    .foreground(DodamColor.Label.neutral)
                    .frame(width: 93, height: 38)
                    .background(DodamColor.Fill.neutral)
                    .cornerRadius(10)
            }
            .padding(.top, 24)
            
            Spacer()
        }
        .padding(.top, 37)
        .padding(.horizontal, 16)
    }
}
