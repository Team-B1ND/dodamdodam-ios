//
//  NotificationCell.swift
//  Feature
//
//  Created by dgsw8th61 on 11/5/24.
//

import SwiftUI
import DDS
import Shared

struct NotificationCell: View {
    private let title: String
    private let content: String
    private let user: String
    private let date: String
    private let images: [String]?
    
    init(
        title: String,
        content: String,
        user: String,
        date: String,
        images: [String]? = nil
    ) {
        self.title = title
        self.content = content
        self.user = user
        self.date = date
        self.images = images
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("\(user) · \(date)")
                        .font(.system(size: 14, weight: .regular))
                        .foreground(DodamColor.Label.assistive)
                }
                
                Text(title)
                    .font(.heading2(.bold))
                    .foreground(DodamColor.Label.normal)
                
                Text(content)
                    .font(.system(size: 14, weight: .regular))
                    .foreground(DodamColor.Label.normal)
                
                if let images = images, !images.isEmpty {
                    HStack(spacing: 8) {
                        if images.count > 2 {
                            AsyncImage(url: URL(string: images[0])) { image in
                                image.resizable()
                            } placeholder: {
                                Color.gray.opacity(0.3)
                            }
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 170, height: 172)
                            .cornerRadius(12)
                            
                            ZStack {
                                AsyncImage(url: URL(string: images[1])) { image in
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
                        } else {
                            ForEach(images, id: \.self) { imageUrl in
                                AsyncImage(url: URL(string: imageUrl)) { image in
                                    image.resizable()
                                } placeholder: {
                                    Color.gray.opacity(0.3)
                                }
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 348, height: 225)
                                .background(DodamColor.Fill.neutral)
                                .cornerRadius(12)
                            }
                        }
                    }
                }
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(16)
        .background(DodamColor.Background.normal)
        .cornerRadius(18)
    }
}
