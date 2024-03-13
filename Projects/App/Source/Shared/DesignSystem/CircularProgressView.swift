//
//  CircularProgressView.swift
//  DodamDodam
//
//  Created by Mercen on 3/13/24.
//

import SwiftUI

public struct CircularProgressView: View {
    
    private let progress: CGFloat
    private let isDisabled: Bool
    
    public init(progress: CGFloat, isDisabled: Bool = false) {
        self.progress = progress
        self.isDisabled = isDisabled
    }
    
    public func disabled(_ condition: Bool = true) -> Self {
        .init(
            progress: self.progress,
            isDisabled: condition
        )
    }
    
    private var foregroundColor: AnyShapeStyle {
        isDisabled ? .init(Color(.tertiary)) : .init(.tint)
    }
    
    public var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 10)
                .foregroundStyle(Color(.secondary))
            Circle()
                .trim(from: 0, to: min(progress, 1))
                .stroke(
                    style:
                        StrokeStyle(
                            lineWidth: 10,
                            lineCap: .round,
                            lineJoin: .round
                        )
                )
                .foregroundStyle(foregroundColor)
                .rotationEffect(.degrees(270))
                .animation(.linear, value: progress)
        }
        .frame(width: 70, height: 70)
    }
}

#Preview {
    struct CircularProgressPreview: View {
        
        @State private var progress: CGFloat = 0.5
        
        var body: some View {
            VStack(spacing: 20) {
                CircularProgressView(progress: progress)
                Slider(value: $progress)
                    .tint(.gray)
            }
            .padding()
        }
    }
    return CircularProgressPreview()
}
