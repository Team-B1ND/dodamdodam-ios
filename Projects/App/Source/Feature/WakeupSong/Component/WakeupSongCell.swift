//
//  WakeupSongCell.swift
//  DodamDodam
//
//  Created by dgsw8th71 on 4/1/24.
//

import SwiftUI
import DDS
import CachedAsyncImage

struct WakeupSongCell: View {
    
    let data: WakeupSongResponse
    
    init(
        data: WakeupSongResponse
    ) {
        self.data = data
    }
    
    var body: some View {
        HStack(spacing: 16) {
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
            .padding(.vertical, 8)
            VStack(alignment: .leading, spacing: 2) {
                Text("\(data.videoTitle)")
                    .font(.body(.medium))
                    .dodamColor(.onSurface)
                    .lineLimit(1)
                Text("\(data.channelTitle)")
                    .font(.label(.large))
                    .dodamColor(.onSurfaceVariant)
                    .lineLimit(1)
                Text("\(data.createdAt)")
                    .font(.label(.small))
                    .dodamColor(.onSurfaceVariant)
            }
            .padding(.vertical, 12)
            Spacer()
        }
    }
}
