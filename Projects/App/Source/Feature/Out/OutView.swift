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
        } content: {
            VStack(spacing: 20) {
                Text("1123")
                    .frame(maxWidth: .infinity)
            }
            .padding(.horizontal, 16)
            .padding(.top, 58)
            .padding(.bottom, 150)
        }
    }
}

#Preview {
    OutView()
}
