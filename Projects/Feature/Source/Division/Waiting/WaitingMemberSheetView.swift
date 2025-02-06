//
//  WaitingMemberSheetView.swift
//  Feature
//
//  Created by dgsw8th61 on 2/5/25.
//

import DDS
import SwiftUI

struct WaitingMemberSheetView: View {
    let member: Member
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(member.name)님 정보")
                .heading1(.bold)
                .foreground(DodamColor.Label.normal)
            
            Text("직군 | 학생")
                .headline(.medium)
                .foreground(DodamColor.Label.assistive)
                .padding(.top, 8)
            
            Text("학번 | 1학년 2반 13번")
                .headline(.medium)
                .foreground(DodamColor.Label.assistive)
                .padding(.top, 8)
            
            HStack(alignment: .center) {
                Button {
                    //
                } label: {
                    Text("거절하기")
                        .body2(.bold)
                        .foreground(DodamColor.Label.neutral)
                        .frame(width: 124, height: 48)
                        .background(DodamColor.Fill.normal)
                        .cornerRadius(12)
                }
                .padding(.trailing, 8)
                Button {
                    //
                } label: {
                    Text("승인하기")
                        .body2(.bold)
                        .foreground(DodamColor.Static.white)
                        .frame(width: 248, height: 48)
                        .background(DodamColor.Primary.normal)
                        .cornerRadius(12)
                }
            }
            .padding(.top, 24)
        
            Spacer()
        }
        .padding(.top, 21)
        .padding(.horizontal, 16)
    }
}
