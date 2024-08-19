//
//  WakeupSongCell.swift
//  DodamDodam
//
//  Created by dgsw8th71 on 4/1/24.
//

import SwiftUI
import DDS
import CachedAsyncImage
import Domain

struct WakeupSongCell: View {
    
    let data: WakeupSongResponse
    
    init(
        data: WakeupSongResponse
    ) {
        self.data = data
    }
    
    func dateString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    var body: some View {
        HStack(spacing: 16) {
            Link(
                destination: URL(string: data.videoUrl)
                ?? URL(string: "about:blank")!
            ) {
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
            }
            VStack(alignment: .leading, spacing: 2) {
                HStack(spacing: 2) {
                    if !(data.status == .pending) {
                        Text("\(data.status.rawValue)")
                            .font(.body1(.medium))
                            .foreground(data.status == .rejected ? DodamColor.Status.negative : DodamColor.Primary.normal)
                    }
                    Text("\(data.videoTitle)")
                        .body1(.bold)
                        .foreground(DodamColor.Label.normal)
                        .lineLimit(1)
                }
                Text("\(data.channelTitle)")
                    .caption1(.medium)
                    .foreground(DodamColor.Label.alternative)
                    .lineLimit(1)
                Text("\(dateString(date: data.createdAt))")
                    .caption2(.regular)
                    .foreground(DodamColor.Label.alternative)
            }
            .padding(.vertical, 12)
            Spacer()
        }
    }
}
