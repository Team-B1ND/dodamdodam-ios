//
//  SegmentedView.swift
//  DodamDodam
//
//  Created by 이민규 on 4/3/24.
//

import SwiftUI
import DDS
import Combine

struct SegmentedView: View {
    
    private let labels: [String]
    
    public init(
        labels: [String],
        selection: Binding<Int>? = nil
    ) {
        self.labels = labels
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
                    }
                } label: {
                    Text(idx == 0 ? labels[0] : labels[1])
                        .font(.body(.large))
                        .dodamColor(
                            isSelected
                            ? .onSurface
                            :.onSurfaceVariant
                        )
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
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
                                    radius: 4,
                                    x: 2,
                                    y: 2
                                )
                        }
                    }
                )
                .padding(4)
            }
        }
        .frame(maxWidth: .infinity)
        .background(Dodam.color(.secondary))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .onChange(of: selected) { newValue in
            selection?.wrappedValue = newValue
            withAnimation(.spring(duration: 0.2)) {
                animatedSelection = newValue
            }
        }
        .onReceive(Just(selection)) { newValue in
            if let newValue,
               selected != newValue.wrappedValue {
                withAnimation(.spring) {
                    selected = newValue.wrappedValue
                }
            }
        }
    }
}
