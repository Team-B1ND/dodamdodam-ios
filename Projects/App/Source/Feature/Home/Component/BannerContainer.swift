//
//  BannerContainer.swift
//  DodamDodam
//
//  Created by 이민규 on 3/18/24.
//

import SwiftUI
import DDS
import CachedAsyncImage

struct BannerContainer: View {
    
    private let bannerData: [BannerResponse]?
    
    public init(
        data bannerData: [BannerResponse]?
    ) {
        self.bannerData = bannerData
    }
    
    var body: some View {
        if let data = bannerData, !data.isEmpty {
            TabView {
                ForEach(data, id: \.self) { data in
                    Link(destination: URL(string: data.redirectUrl) ?? URL(string: "about:blank")!) {
                        CachedAsyncImage(url: URL(string: data.imageUrl)) {
                            $0.resizable()
                        } placeholder: {
                            Rectangle()
                                .shimmer()
                        }
                    }
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .aspectRatio(80/12, contentMode: .fill)
            .frame(maxWidth: .infinity)
            .clipShape(RoundedRectangle(cornerRadius: 18))
        }
    }
}
