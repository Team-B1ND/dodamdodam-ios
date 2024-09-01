//
//  BannerContainer.swift
//  DodamDodam
//
//  Created by 이민규 on 3/18/24.
//

import SwiftUI
import DDS
import CachedAsyncImage
import Domain

struct BannerContainer: View {
    
    private let bannerData: [BannerResponse]?
    
    public init(
        data bannerData: [BannerResponse]?
    ) {
        self.bannerData = bannerData
    }
    
    var body: some View {
        Group {
            if let data = bannerData {
                if data.isEmpty {
                    Text("배너가 없어요")
                        .body1(.regular)
                        .foreground(DodamColor.Label.assistive)
                } else {
                    TabView {
                        ForEach(data, id: \.self) { data in
                            Link(destination: URL(string: data.redirectUrl) ?? URL(string: "about:blank")!) {
                                CachedAsyncImage(url: URL(string: data.imageUrl)) {
                                    $0
                                        .resizable()
                                } placeholder: {
                                    Rectangle()
                                        .shimmer()
                                }
                            }
                        }
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                }
            } else {
                DodamLoadingView.conditional(true) {
                    Rectangle()
                        .shimmer()
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .aspectRatio(80 / 12, contentMode: .fit)
        .background(DodamColor.Background.normal)
        .clipShape(.large)
    }
}
