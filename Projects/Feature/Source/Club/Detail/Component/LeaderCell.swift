//
//  LeaderCell.swift
//  Feature
//
//  Created by dgsw30 on 2/26/25.
//

import SwiftUI
import DDS
import Domain
import CachedAsyncImage

extension StateType {
    var mark: StateTypeTag? {
        switch self {
        case .allowed:
            return StateTypeTag(title: "승인됨", type: .primary)
        case .waiting:
            return StateTypeTag(title: "대기중", type: .secondary)
        case .deleted:
            return StateTypeTag(title: "거절됨", type: .negative)
        case .pending, .rejected:
            return nil
        }
    }
}

struct LeaderCell: View {
    private let data: ClubAllMembersResponse
    
    init(for data: ClubAllMembersResponse) {
        self.data = data
    }
    
    var body: some View {
        HStack {
            DodamAvatar.extraSmall(url: data.profileImage)
                .padding(.horizontal, 1)
            
            VStack(alignment: .leading) {
                HStack {
                    Text(data.name)
                        .font(.body1(.medium))
                        .foreground(DodamColor.Label.normal)
                    
                    if data.permission == .clubLeader {
                        Image(icon: .crown)
                    }
                }
                
                Text("\(data.grade)-\(data.room)")
                    .font(.body2(.medium))
                    .foreground(DodamColor.Label.alternative)
            }
            Spacer()
            
            data.status.mark
        }
        .padding(.horizontal)
    }
}
