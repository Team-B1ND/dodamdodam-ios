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

struct NoticeCell: View {
    private let notice: NoticeResponse
    
    init(notice: NoticeResponse) {
        self.notice = notice
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("\(notice.memberInfoRes.name) · \(notice.createdAt.parseString(format: "yyyy년 MM월 dd일"))")
                    .font(.system(size: 14, weight: .regular))
                    .foreground(DodamColor.Label.assistive)
            }
            
            Text(notice.title)
                .font(.heading2(.bold))
                .foreground(DodamColor.Label.normal)
            
            Text(notice.content)
                .font(.system(size: 14, weight: .regular))
                .foreground(DodamColor.Label.normal)
            
            
//            if let images = notice.fileUrl, !images.isEmpty {
//                HStack(spacing: 8) {
//                    if images.count > 2 {
//                        AsyncImage(url: URL(string: images[0])) { image in
//                            image.resizable()
//                        } placeholder: {
//                            Color.gray.opacity(0.3)
//                        }
//                        .aspectRatio(contentMode: .fill)
//                        .frame(width: 170, height: 172)
//                        .cornerRadius(12)
//                        
//                        ZStack {
//                            AsyncImage(url: URL(string: images[1])) { image in
//                                image.resizable()
//                            } placeholder: {
//                                Color.gray.opacity(0.3)
//                            }
//                            .aspectRatio(contentMode: .fill)
//                            .frame(width: 170, height: 172)
//                            .cornerRadius(12)
//                            .overlay(
//                                Color.black.opacity(0.5)
//                                    .cornerRadius(12)
//                            )
//                            Text("\(images.count - 1)+")
//                                .font(.title1(.regular))
//                                .foregroundColor(.white)
//                        }
//                    } else {
//                        ForEach(images, id: \.self) { imageUrl in
//                            AsyncImage(url: URL(string: imageUrl)) { image in
//                                image.resizable()
//                            } placeholder: {
//                                Color.gray.opacity(0.3)
//                            }
//                            .aspectRatio(contentMode: .fit)
//                            .frame(width: 348, height: 225)
//                            .background(DodamColor.Fill.neutral)
//                            .cornerRadius(12)
//                        }
//                    }
//                }
//            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .background(DodamColor.Background.normal)
        .clipShape(.large)
    }
}

/*
 .title,
 content: notice.content,
 user: notice.memberInfoRes.name,
 date: notice.createdAt.parseString(format: "yyyy년 MM월 dd일"),
 images: notice.fileUrl.map { [$0] } ?? nil*/
