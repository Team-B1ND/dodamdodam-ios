//
//  WakeupSongContainer.swift
//  DodamDodam
//
//  Created by 이민규 on 3/17/24.
//

import SwiftUI
import DDS
import CachedAsyncImage
import SignKit
import Domain

struct WakeupSongContainer: View {
    
    private let wakeupSongData: [WakeupSongResponse]?
    
    init(
        data wakeupSongData: [WakeupSongResponse]?
    ) {
        self.wakeupSongData = wakeupSongData
    }
    
    var body: some View {
        if let data = wakeupSongData {
            if !data.isEmpty {
                DodamPageView {
                    ForEach(data, id: \.self) { data in
                        HStack(alignment: .top, spacing: 12) {
                            Link(destination: URL(string: data.videoUrl) ?? URL(string: "about:blank")!) {
                                CachedAsyncImage(url: URL(string: data.thumbnail)) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 120, height: 67)
                                        .clipShape(.medium)
                                } placeholder: {
                                    Rectangle()
                                        .frame(width: 120, height: 67)
                                        .clipShape(.medium)
                                        .shimmer()
                                }
                            }
                            /// marquee 적용 하기
                            VStack(alignment: .leading, spacing: 0) {
                                Text("\(data.videoTitle)")
                                    .body1(.medium)
                                    .foreground(DodamColor.Label.normal)
                                    .lineLimit(1)
                                Text("\(data.channelTitle)")
                                    .label(.medium)
                                    .foreground(DodamColor.Label.alternative)
                                    .lineLimit(1)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .page()
                    }
                }
                .frame(height: 80)

            } else {
                SupportingContainer(
                    subTitle: "승인된 기상송이 없어요",
                    title: Sign.isLoggedIn ? "기상송 신청하기" : "신청하려면 로그인하세요"
                )
            }
        } else {
            DodamLoadingView()
                .frame(height: 80)
        }
    }
}
