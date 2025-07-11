//
//  ApproveSheetCell.swift
//  Feature
//
//  Created by 김은찬 on 7/7/25.
//

import SwiftUI
import DDS
import Domain

struct ApproveNightStudySheetCell: View {
    let data: OngoingNightStudyResponse
    let approve: () -> Void
    let reject: () -> Void
    
    init(data: OngoingNightStudyResponse, approve: @escaping () -> Void, reject: @escaping () -> Void
    ) {
        self.data = data
        self.approve = approve
        self.reject = reject
    }
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Text("\(data.student.name)님의 심야 자습 정보")
                    .font(.heading1(.bold))
                    .foreground(DodamColor.Label.normal)
                
                Spacer()
            }
            
            HStack {
                Text("시작 날짜")
                    .font(.headline(.medium))
                    .foreground(DodamColor.Label.assistive)
                
                Spacer()
                
                Text(data.startAt.parseString(format: "M월 d일"))
                    .font(.headline(.medium))
                    .foreground(DodamColor.Label.neutral)
            }
            
            HStack {
                Text("종료 날짜")
                    .font(.headline(.medium))
                    .foreground(DodamColor.Label.assistive)
                
                Spacer()
                
                Text(data.endAt.parseString(format: "M월 d일"))
                    .font(.headline(.medium))
                    .foreground(DodamColor.Label.neutral)
            }
            
            HStack {
                Text("학습 계획")
                    .font(.headline(.medium))
                    .foreground(DodamColor.Label.assistive)
                
                Spacer()
                
                Text(data.content)
                    .font(.headline(.medium))
                    .foreground(DodamColor.Label.neutral)
            }
            
            if data.doNeedPhone {
                HStack {
                    Text("휴대폰 사용")
                        .font(.headline(.medium))
                        .foreground(DodamColor.Label.assistive)
                    
                    Spacer()
                    
                    Text(data.reasonForPhone ?? "X")
                        .font(.headline(.medium))
                        .foreground(DodamColor.Label.neutral)
                }
            }
            
            HStack(spacing: 8) {
                DodamButton.fullWidth(
                    title: "거절하기"
                ) {
                    reject()
                }
                .role(.assistive)
                .frame(maxWidth: UIScreen.main.bounds.width * 0.3)
                
                DodamButton.fullWidth(
                    title: "승인하기"
                ) {
                    approve()
                }
                .frame(maxWidth: UIScreen.main.bounds.width * 0.6)
            }
            .padding(.top, 24)
            .frame(maxWidth: .infinity)
        }
    }
}
