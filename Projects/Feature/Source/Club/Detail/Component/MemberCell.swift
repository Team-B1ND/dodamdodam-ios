//
//  MemberCell.swift
//  Feature
//
//  Created by dgsw30 on 2/19/25.
//

import SwiftUI
import DDS
import Domain
import CachedAsyncImage

struct MemberCell: View {
    private let data: ClubMembersResponse
    
    init(for data: ClubMembersResponse) {
        self.data = data
    }
    
    var body: some View {
        HStack {
            DodamAvatar.medium(url: data.profileImage)
                .padding(.horizontal, 1)
            
            Text(data.name)
                .font(.body1(.medium))
                .foreground(DodamColor.Label.normal)
            
            if data.permission == .clubLeader {
                Image(icon: .crown)
            }
            
            Spacer()
            Text("\(data.grade)-\(data.room)")
                .font(.body2(.medium))
                .foreground(DodamColor.Label.alternative)
        }
        .padding(.horizontal, 4)
    }
}
