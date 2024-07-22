//
//  Container.swift
//  DodamDodam
//
//  Created by 이민규 on 3/17/24.
//

import SwiftUI
import DDS

public struct DodamContainer<Content>: View where Content: View {
    
    private let title: String
    private let icon: Image
    private let content: () -> Content
    
    private init(
        title: String,
        icon: Image,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.title = title
        self.icon = icon
        self.content = content
    }
    
    public static func `default`(
        title: String,
        icon: Image,
        @ViewBuilder content: @escaping () -> Content
    ) -> Self {
        .init(
            title: title,
            icon: icon,
            content: content
        )
    }
    
    public var body: some View {
        VStack(spacing: 6) {
            HStack(spacing: 12) {
                icon
                    .resizable()
                    .frame(width: 16, height: 16)
                    .foreground(DodamColor.Static.white)
                    .frame(width: 32, height: 32)
                    .background(DodamColor.Primary.alternative)
                    .clipShape(Circle())
                    .padding(.leading, 6)
                Text("\(title)")
                    .headline(.bold)
                    .foreground(DodamColor.Label.strong)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
                Spacer()
            }
            content()
        }
        .padding(.top, 16)
        .padding(.bottom, 10)
        .padding(.horizontal, 10)
        .background(DodamColor.Background.normal)
        .clipShape(.large)
    }
}

#Preview {
    struct DodamContainerPreview: View {
        
        var body: some View {
            VStack(spacing: 20) {
                DodamContainer.default(
                    title: "오늘의 급식",
                    icon: Dodam.icon(.forkAndKnife)
                ) {
                    Text("contents")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                DodamContainer.default(
                    title: "오늘의 기상송",
                    icon: Dodam.icon(.note)
                ) {
                    Text("contents")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .padding(16)
            .background(DodamColor.Background.neutral)
        }
    }
    return DodamContainerPreview()
}
