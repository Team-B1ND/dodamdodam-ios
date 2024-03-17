//
//  Container.swift
//  DodamDodam
//
//  Created by 이민규 on 3/17/24.
//

import SwiftUI

public struct DodamContainer<Content>: View where Content: View {
    
    private let title: String
    private let icon: Image
    private let isUseRightButton: Bool
    private let content: () -> Content
    private let action: () -> Void
    
    private init(
        title: String,
        icon: Image,
        isUseRightButton: Bool = false,
        action: @escaping () -> Void = {},
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.title = title
        self.icon = icon
        self.isUseRightButton = isUseRightButton
        self.action = action
        self.content = content
    }
    
    public func arrowButtonAction(_ action: @escaping () -> Void) -> Self {
        .init(title: title,
              icon: icon,
              isUseRightButton: true,
              action: action,
              content: content
        )
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
                .background(Color(.primary))
                .clipShape(RoundedRectangle(cornerRadius: 32))
                Text("\(title)")
                    .font(.dodamTitle2)
                    .foregroundStyle(Color(.onSurfaceVariant))
                Spacer()
                if isUseRightButton {
                    Button {
                        action()
                    } label: {
                        Image(.chevronRight)
                            .resizable()
                            .frame(width: 16, height: 16)
                            .foregroundStyle(Color(.tertiary))
                    }
                }
            }
            .padding([.top, .horizontal], 16)
            content()
        }
        .background(Color(.surfaceVariant))
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }
}

#Preview {
    struct DodamContainerPreview: View {
        
        var body: some View {
            VStack(spacing: 20) {
                DodamContainer.default(
                    title: "오늘의 급식",
                    icon: Image(.forkAndKnife)
                ) {
                    Text("contents")
                        .padding([.bottom, .horizontal], 16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                DodamContainer.default(
                    title: "오늘의 기상송",
                    icon: Image(.note)
                ) {
                    Text("contents")
                        .padding([.bottom, .horizontal], 16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .arrowButtonAction {
                    print("화살표 액션")
                }
            }
            .padding(16)
            .background(Color(.surface))
        }
    }
    return DodamContainerPreview()
}
