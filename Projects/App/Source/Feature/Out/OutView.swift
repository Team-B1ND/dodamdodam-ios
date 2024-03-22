//
//  OutView.swift
//  DodamDodam
//
//  Created by 이민규 on 3/21/24.
//

import SwiftUI
import DDS

struct OutView: View {
    
    @InjectObject var viewModel: OutViewModel
    @Flow var flow
    
    var body: some View {
        DodamScrollView {
            VStack(spacing: 12) {
                HStack {
                    Text("외출/외박")
                        .font(.headline(.small))
                        .dodamColor(.onBackground)
                        .padding(.leading, 20)
                    Spacer()
                    Button {
                        // bell action
                    } label: {
                        Dodam.icon(.plus)
                            .resizable()
                            .frame(width: 24, height: 24)
                            .dodamColor(.tertiary)
                    }
                    .frame(width: 44, height: 44)
                    .padding(.trailing, 12)
                }
                .frame(height: 58)
                OutSegmentedView(selection: $viewModel.selection)
                    .padding(.horizontal, 16)
                Rectangle()
                    .frame(height: 8)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.clear)
            }
            .frame(maxWidth: .infinity)
            .background(.regularMaterial)
        } content: {
            VStack(spacing: 12) {
                Text("adawd")
                Text("adawd")
                Text("adawd")
                Text("adawd")
            }
            .padding(.horizontal, 16)
        }
    }
}

#Preview {
    OutView()
}
