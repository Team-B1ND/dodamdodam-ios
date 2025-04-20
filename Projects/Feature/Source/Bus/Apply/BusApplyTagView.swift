//
//  BusApplyTagView.swift
//  Feature
//
//  Created by hhhello0507 on 2/26/25.
//

import SwiftUI
import DDS
import FlowKit
import Shared

struct BusApplyTagView: View {
    @StateObject private var viewModel: BusApplyTagViewModel
    @Flow private var flow
    
    init(busId: Int) {
        self._viewModel = .init(wrappedValue: .init(busId: busId))
    }
    
    var body: some View {
        VStack(spacing: 0) {
            DodamTopAppBar.medium(
                title: "QR리더기에 태깅해주세요"
            )
            Spacer()
            if let nonce = viewModel.nonce {
                QRCodeView.from(string: nonce)
                    .foregroundStyle(.secondary)
                    .padding(24)
                    .frame(width: 280, height: 280)
                    .overlay {
                        VStack {
                            HStack {
                                SupportView()
                                Spacer()
                                SupportView()
                                    .rotationEffect(.degrees(90))
                            }
                            Spacer()
                            HStack {
                                SupportView()
                                    .rotationEffect(.degrees(270))
                                Spacer()
                                SupportView()
                                    .rotationEffect(.degrees(180))
                            }
                        }
                    }
            } else {
                DodamLoadingView()
            }
            Spacer()
            DodamButton.fullWidth(
                title: "완료"
            ) {
                flow.pop(2)
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 12)
        }
        .task {
            await viewModel.onAppear()
        }
    }
}

private struct SupportView: View {
    var body: some View {
        HStack(alignment: .top, spacing: -6) {
            RoundedRectangle(cornerRadius: 3)
                .dodamFill(DodamColor.Primary.normal)
                .frame(width: 6, height: 38)
            RoundedRectangle(cornerRadius: 3)
                .dodamFill(DodamColor.Primary.normal)
                .frame(width: 38, height: 6)
        }
    }
}

#Preview {
    SupportView()
}
