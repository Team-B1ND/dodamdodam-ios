//
//  WakeupSongContainer.swift
//  DodamDodam
//
//  Created by 이민규 on 3/17/24.
//

import SwiftUI

struct WakeupSongContainer: View {
    
    let dummy1 = WakeupSong(
        id: 73,
        thumbnailUrl: "https://i.ytimg.com/vi/7jxlsVRylq8/sddefault.jpg",
        videoTitle: "Flowering (개화 (Flowering))",
        videoId: "7jxlsVRylq8",
        videoUrl: "https://music.youtube.com/watch?v=7jxlsVRylq8&si=JUNLf--vr2hvWFH2",
        channelTitle: "LUCY - Topic",
        status: "ALLOWED",
        createdAt: "test-te-st"
    )
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Link(destination: URL(string: dummy1.videoUrl) ?? URL(string: "about:blank")!) {
                AsyncImage(url: URL(string: dummy1.thumbnailUrl)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 160/1.2, height: 90/1.2)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                } placeholder: {
                    Rectangle()
                        .frame(width: 160/1.2, height: 90/1.2)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                
            }
            VStack(alignment: .leading, spacing: 4) {
                Text("\(dummy1.videoTitle)")
                    .font(.dodamBody2)
                    .foregroundStyle(Color(.onSurfaceVariant))
                Text("\(dummy1.channelTitle)")
                    .font(.dodamLabel2)
                    .foregroundStyle(Color(.tertiary))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    WakeupSongContainer()
}

struct WakeupSong: Codable, Hashable {
    let id: Int
    let thumbnailUrl: String
    let videoTitle: String
    let videoId: String
    let videoUrl: String
    let channelTitle: String
    let status: String
    let createdAt: String
}
