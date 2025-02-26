//
//  MyClubView.swift
//  Feature
//
//  Created by dgsw30 on 2/19/25.
//

import SwiftUI
import DDS
import FlowKit

struct MyClubView: View {
    @Flow var flow
    
    var body: some View {
        DodamScrollView.medium(title: "내동아리") {
            VStack {
                DodamEmptyView(
                    title: "아직 동아리에 신청하지 않았어요!\n신청 마감 : 2025. 03. 19.",
                    icon: .fullMoonFace,
                    buttonTitle: "동아리 입부 신청하기"
                ) {
                    flow.push(ApplyView())
                }
                .padding(.vertical)
            }
            .padding(.horizontal, 16)
            
            MyApplyCell() //내신청
            
            AffiliationCell() //소속된 동아리
            
            CreateClubCell() //내 개설 신청
            
            SugestCell() //부원 제안
        }
        .background(DodamColor.Background.neutral)
    }
}

#Preview {
    MyClubView()
}
