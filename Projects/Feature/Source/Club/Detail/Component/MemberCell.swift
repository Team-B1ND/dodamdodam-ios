//
//  MemberCell.swift
//  Feature
//
//  Created by dgsw30 on 2/19/25.
//

import SwiftUI
import DDS
import Domain

struct MemberCell: View {
    private let data: ClubMembersResponse
    
    init(for data: ClubMembersResponse) {
        self.data = data
    }
    
    var body: some View {
        HStack {
            Circle()
                .frame(width: 30, height: 30)
                .padding(.horizontal, 1)
            
            Text(data.name)
                .font(.body1(.medium))
                .foreground(DodamColor.Label.normal)
            
            if data.permission == .clubLeader { // 왕관 dds에 추가해야함
                Image(systemName: "crown.fill")
                    .foregroundColor(.yellow)
                    .font(.system(size: 14))
            }
            
            Spacer()
            Text("\(data.grade)-\(data.room)")
                .font(.body2(.medium))
                .foreground(DodamColor.Label.alternative)
        }
        .padding(.horizontal, 4)
    }
}
