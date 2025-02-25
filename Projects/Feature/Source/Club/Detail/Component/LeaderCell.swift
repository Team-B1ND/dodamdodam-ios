//
//  LeaderCell.swift
//  Feature
//
//  Created by dgsw30 on 2/26/25.
//

import SwiftUI
import DDS
import Domain

struct LeaderCell: View {
    private let data: ClubAllMembersResponse
    
    init(for data: ClubAllMembersResponse) {
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
            Spacer()
            Text("\(data.grade)-\(data.room)")
                .font(.body2(.medium))
                .foreground(DodamColor.Label.alternative)
        }
        .padding(.horizontal, 4)
    }
}
