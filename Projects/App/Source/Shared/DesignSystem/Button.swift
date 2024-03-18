//
//  Button.swift
//  DodamDodam
//
//  Created by Mercen on 3/12/24.
//

import SwiftUI

public struct DodamButton: View {
    
    public typealias AsyncAction = () async -> Void
    
    private let title: String
    private let icon: Image?
    private let action: AsyncAction
    private let font: Font
    private let iconSize: CGFloat
    private let height: CGFloat
    private let padding: CGFloat?
    
    private init(
        title: String,
        icon: Image?,
        action: @escaping AsyncAction,
        font: Font = .dodamBody2,
        iconSize: CGFloat = 19,
        height: CGFloat = 48,
        padding: CGFloat? = nil
    ) {
        self.title = title
        self.icon = icon
        self.action = action
        self.font = font
        self.iconSize = iconSize
        self.height = height
        self.padding = padding
    }
    
    public static func fullWidth(
        title: String,
        icon: Image? = nil,
        action: @escaping AsyncAction
    ) -> Self {
        .init(
            title: title,
            icon: icon,
            action: action
        )
    }
    
    public static func large(
        title: String,
        icon: Image? = nil,
        action: @escaping AsyncAction
    ) -> Self {
        .init(
            title: title,
            icon: icon,
            action: action,
            padding: 16
        )
    }
    
    public static func medium(
        title: String,
        icon: Image? = nil,
        action: @escaping AsyncAction
    ) -> Self {
        .init(
            title: title,
            icon: icon,
            action: action,
            height: 36,
            padding: 8
        )
    }
    
    public static func small(
        title: String,
        icon: Image? = nil,
        action: @escaping AsyncAction
    ) -> Self {
        .init(
            title: title,
            icon: icon,
            action: action,
            font: .system(size: 14, weight: .regular),
            iconSize: 17,
            height: 28,
            padding: 8
        )
    }
    
    @State private var isPerformingTask = false
    
    private var maxWidth: CGFloat? {
        guard padding != nil else { return .infinity }
        return nil
    }
    
    private var cornerRadius: CGFloat {
        height >= 48 ? 10 : 8
    }
    
    public var body: some View {
        Button {
            withAnimation(.none) {
                isPerformingTask = true
            }
            Task {
                await action()
                isPerformingTask = false
            }
        } label: {
            HStack(spacing: 8) {
                if let icon {
                    icon
                        .resizable()
                        .scaledToFit()
                        .frame(
                            width: iconSize,
                            height: iconSize
                        )
                }
                Text(title)
                    .font(font)
            }
            .opacity(isPerformingTask ? 0 : 1)
            .frame(height: height)
            .padding(.horizontal, padding)
            .frame(maxWidth: maxWidth)
            .foregroundStyle(Color(.onPrimary))
        }
        .disabled(isPerformingTask)
        .background(.tint)
        .clipShape(
            RoundedRectangle(cornerRadius: cornerRadius)
        )
        .opacity(isPerformingTask ? 0.5 : 1)
        .background(
            Group {
                if isPerformingTask {
                    DodamLoadingView()
                }
            }
        )
    }
}

#Preview {
    VStack(alignment: .leading) {
        let title = "Button"
        let icon = Image(.home)
        let action: () async -> Void = {
            try? await Task.sleep(seconds: 1)
        }
        DodamButton.fullWidth(
            title: title,
            icon: icon,
            action: action
        )
        DodamButton.large(
            title: title,
            icon: icon,
            action: action
        )
        DodamButton.medium(
            title: title,
            icon: icon,
            action: action
        )
        DodamButton.small(
            title: title,
            icon: icon,
            action: action
        )
    }
    .padding()
}
