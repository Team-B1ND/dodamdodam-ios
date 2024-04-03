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
        VStack(spacing: 12) {
            HStack(spacing: 12) {
                ZStack {
                    icon
                        .resizable()
                        .frame(width: 16, height: 16)
                        .foregroundStyle(Color(.white))
                        .padding(6)
                }
                .frame(width: 32, height: 32)
                .background(Dodam.color(.primary).opacity(0.65))
                .clipShape(RoundedRectangle(cornerRadius: 32))
                Text("\(title)")
                    .font(.title(.medium))
                    .minimumScaleFactor(0.01)
                    .dodamColor(.onSurface)
                Spacer()
            }
            .padding([.top, .leading], 16)
            content()
                .padding([.bottom, .horizontal], 10)
        }
        .background(Dodam.color(.surfaceContainer))
        .clipShape(RoundedRectangle(cornerRadius: 18))
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
            .background(Dodam.color(.surface))
        }
    }
    return DodamContainerPreview()
}
