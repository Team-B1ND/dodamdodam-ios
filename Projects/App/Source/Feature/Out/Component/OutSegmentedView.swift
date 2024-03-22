//
//  OutSegmentedView.swift
//  DodamDodam
//
//  Created by 이민규 on 3/22/24.
//

import SwiftUI
import DDS

struct OutSegmentedView: View {
    
    public init(
        selection: Binding<Int>? = nil
    ) {
        self.selection = selection
        let selected = selection?.wrappedValue ?? 0
        self.selected = selected
        self.animatedSelection = selected
    }
    
    @Namespace private var animation
    @State private var selection: Binding<Int>?
    @State private var selected: Int
    @State private var animatedSelection: Int
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<2) { idx in
                let isSelected = animatedSelection == idx
                Button {
                    if selected != idx {
                        selected = idx
                        withAnimation(.spring(duration: 0.2)) {
                            animatedSelection = idx
                        }
                    }
                } label: {
                    Text(idx == 0 ? "외출" : "외박")
                        .font(.title(.small))
                        .dodamColor(.onSurfaceVariant)
                        .frame(height: 44)
                        .frame(maxWidth: .infinity)
                }
                .background(
                    Group {
                        if isSelected {
                            RoundedRectangle(cornerRadius: 10)
                                .dodamFill(.surfaceContainer)
                                .matchedGeometryEffect(
                                    id: 0,
                                    in: animation
                                )
                                .shadow(
                                    color: .black.opacity(0.1),
                                    radius: 4, x: 2, y: 2
                                )
                        }
                    }
                )
                .padding([.horizontal, .vertical], 4)
            }
        }
        .frame(maxWidth: .infinity)
        .background(Dodam.color(.secondary))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    OutSegmentedView()
        .padding(.horizontal, 16)
}
