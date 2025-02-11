//
//  MemberDetailSheetView.swift
//  Feature
//
//  Created by dgsw8th61 on 2/5/25.
//

import SwiftUI
import DDS

struct MemberDetailSheetView: View {
    let member: Member
    let id: Int
    @StateObject private var viewModel = DivisionDetailViewModel()

    var body: some View {
        VStack(alignment: .leading) {
            Text("\(member.name)님 정보")
                .heading1(.bold)
                .foreground(DodamColor.Label.normal)
            
            Text("\(member.grade)학년 \(member.room)반 \(member.number)번")
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
                    }, label: {
                        Text("승격하기")
                    })
                    
                    Button(action: {
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
            
            if let role = member.role {
                Text(role)
                    .headline(.medium)
                    .foreground(DodamColor.Label.assistive)
                    .padding(.top, 8)
            }
            
            Button {
                if let memberId = member.id {
                    Task {
                        await viewModel.deleteMembers(id: id, idList: [member.id!])
                    }
                } else {
                    print("삭제할 멤버의 ID가 없음")
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
