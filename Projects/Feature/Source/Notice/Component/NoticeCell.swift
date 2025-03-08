//
//  NoticeCell.swift
//  Feature
//
//  Created by dgsw8th61 on 11/5/24.
//

import SwiftUI
import DDS
import Shared
import Domain
import CachedAsyncImage

struct NoticeCell: View {
    private let notice: NoticeResponse
    
    init(notice: NoticeResponse) {
        self.notice = notice
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("\(notice.memberInfoRes.name) · \(notice.createdAt.parseString(format: "yyyy년 MM월 dd일"))")
                .font(.system(size: 14, weight: .regular))
                .foreground(DodamColor.Label.assistive)
            
            Text(notice.title)
                .font(.heading2(.bold))
                .foreground(DodamColor.Label.normal)
            
            Text(.init(notice.content))
                .font(.system(size: 14, weight: .regular))
                .foreground(DodamColor.Label.normal)
            
            let images = notice.noticeFileRes.find(fileType: .image)
            if !images.isEmpty {
                if images.count == 1 {
                    let image = images[0]
                    if let url = image.fileUrl {
                        CachedAsyncImage(url: url) { view in
                            view
                                .resizable()
                                .scaledToFit()
                        } placeholder: {
                            Rectangle()
                                .shimmer()
                        }
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                        .frame(height: 225)
                        .background(DodamColor.Fill.neutral)
                        .cornerRadius(12)
                    }
                } else {
                    HStack(spacing: 8) {
                        CachedAsyncImage(url: images[0].fileUrl) { image in
                            image
                                .resizable()
                                .scaledToFit()
                        } placeholder: {
                            Rectangle()
                                .shimmer()
                        }
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 170, height: 172)
                        .cornerRadius(12)
                        
                        ZStack {
                            CachedAsyncImage(url: images[1].fileUrl) { image in
                                image.resizable()
                            } placeholder: {
                                Color.gray.opacity(0.3)
                            }
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 170, height: 172)
                            .cornerRadius(12)
                            .overlay(
                                Color.black.opacity(0.5)
                                    .cornerRadius(12)
                            )
                            Text("\(images.count - 1)+")
                                .font(.title1(.regular))
                                .foregroundColor(.white)
                        }
                    }
                }
            }
            
            ForEach(notice.noticeFileRes.find(fileType: .file), id: \.self) { file in
                NoticeFile(noticeFile: file)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .background(DodamColor.Background.normal)
        .clipShape(.large)
    }
}
