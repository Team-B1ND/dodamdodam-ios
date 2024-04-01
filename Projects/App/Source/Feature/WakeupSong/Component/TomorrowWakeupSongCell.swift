//
//  WakeupSongCell.swift
//  DodamDodam
//
//  Created by dgsw8th71 on 4/1/24.
//

import SwiftUI
import DDS

struct TomorrowWakeupSongCell: View {
    
    let id: Int
    let title: String
    let channel: String
    
    init(
        id: Int,
        title: String,
        channel: String
    ) {
        self.id = id
        self.title = title
        self.channel = channel
    }
    
    var body: some View {
        HStack(spacing: 16) {
            Text("\(id)")
                .font(.label(.large))
                .dodamColor(.primary)
            Image(.onboard)
                .resizable()
                .frame(width: 120, height: 67)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .padding(.vertical, 8)
            VStack(alignment: .leading, spacing: 2) {
                Text("\(title)")
                    .font(.body(.medium))
                    .dodamColor(.onSurface)
                    .lineLimit(1)
                Text("\(channel)")
                    .font(.label(.large))
                    .dodamColor(.onSurfaceVariant)
                    .lineLimit(1)
            }
            .padding(.vertical, 12)
            Spacer()
        }
    }
}
