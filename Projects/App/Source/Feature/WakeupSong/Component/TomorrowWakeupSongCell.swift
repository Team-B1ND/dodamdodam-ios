//
//  WakeupSongCell.swift
//  DodamDodam
//
//  Created by dgsw8th71 on 4/1/24.
//

import SwiftUI
import DDS
import CachedAsyncImage

struct TomorrowWakeupSongCell: View {
    
    let data: WakeupSongResponse
    let id: Int
    
    init(
        data: WakeupSongResponse,
        id: Int
    ) {
        self.data = data
        self.id = id
    }
    
    var body: some View {
        HStack(spacing: 16) {
            Text("\(id)")
                .font(.label(.large))
                .dodamColor(.primary)
                .frame(width: 8, height: 20)
            CachedAsyncImage(url: URL(string: data.thumbnail)) {
                $0
                    .resizable()
                    .frame(width: 120, height: 67)
            } placeholder: {
                Rectangle()
                    .frame(width: 120, height: 67)
                    .shimmer()
            }
            .clipShape(RoundedRectangle(cornerRadius: 10))
            VStack(alignment: .leading, spacing: 2) {
                Text("\(data.videoTitle)")
                    .font(.body(.medium))
                    .dodamColor(.onSurface)
                    .lineLimit(1)
                Text("\(data.channelTitle)")
                    .font(.label(.large))
                    .dodamColor(.onSurfaceVariant)
                    .lineLimit(1)
            }
            .padding(.vertical, 12)
            Spacer()
        }
    }
}
