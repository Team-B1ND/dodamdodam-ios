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
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(member.name)님 정보")
                .heading1(.bold)
                .foreground(DodamColor.Label.normal)
            
            Text("1학년 2반 13번")
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
                //
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
