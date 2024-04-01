//
//  WakeupSongCell.swift
//  DodamDodam
//
//  Created by dgsw8th71 on 4/1/24.
//

import SwiftUI
import DDS

struct WakeupSongCell: View {
    
    let title: String
    let artist: String
    let createAt: String
    
    init(
        title: String,
        artist: String,
        createAt: String
    ) {
        self.title = title
        self.artist = artist
        self.createAt = createAt
    }
    
    var body: some View {
        HStack(spacing: 16) {
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
                Text("\(artist)")
                    .font(.label(.large))
                    .dodamColor(.onSurfaceVariant)
                Text("\(createAt)")
                    .font(.label(.small))
                    .dodamColor(.onSurfaceVariant)
                    .lineLimit(1)
            }
            .padding(.vertical, 12)
            Spacer()
        }
    }
}
