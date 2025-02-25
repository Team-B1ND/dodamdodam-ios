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
                DodamButton.fullWidth(
                    title: "동아리 입부 신청하기"
                ) {
                    flow.push(ApplyView())
                }
                .padding(.vertical)
                
                VStack(alignment: .center, spacing: 6) {
                    VStack {
                        Text("아직 동아리에\n 신청하지 않았어요!")
                            .font(.body2(.bold))
                            .foreground(DodamColor.Label.normal)
                        
                        Text("신청 마감 : 2025. 03. 19.")
                            .font(.caption2(.medium))
                            .foreground(DodamColor.Label.alternative)
                            .padding(.top, 1)
                    }
                    .padding(.vertical, 40)
                }
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
//                .frame(height: 300)
                .background(DodamColor.Background.normal)
                .clipShape(.medium)
            }
            .padding(.horizontal)
            
            MyApplyCell()
            
            AffiliationCell()
            
            CreateClubCell()
            
            SugestCell()
        }
        .background(DodamColor.Background.neutral)
    }
}

#Preview {
    MyClubView()
}
