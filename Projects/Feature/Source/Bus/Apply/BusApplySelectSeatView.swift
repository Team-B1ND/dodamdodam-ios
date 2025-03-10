//
//  BusApplySelectSeatView.swift
//  Feature
//
//  Created by hhhello0507 on 2/26/25.
//

import SwiftUI
import DDS
import FlowKit

struct BusApplySelectSeatView: View {
    @Flow private var flow
    @EnvironmentObject private var dialog: DialogProvider
    @StateObject private var viewModel: BusApplySelectSeatViewModel
    
    init(busId: Int) {
        self._viewModel = StateObject(wrappedValue: BusApplySelectSeatViewModel(busId: busId))
    }
    
    var body: some View {
        DodamScrollView.medium(
            title: "버스 좌석을\n선택해 주세요"
        ) {
            ZStack {
                VStack(spacing: 4) {
                    Image(icon: .arrowLeft)
                        .resizable()
                        .frame(width: 22, height: 22)
                        .foreground(DodamColor.Label.assistive)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .frame(height: 58)
                    ForEach(0..<11, id: \.self) { rowIndex in
                        if rowIndex < 10 {
                            HStack(spacing: 4) {
                                let offset = rowIndex * 4
                                BusSeat(seatNumber: offset + 1, selectedSeatNumber: $viewModel.seatNumber)
                                BusSeat(seatNumber: offset + 2, selectedSeatNumber: $viewModel.seatNumber)
                                Spacer().frame(width: 44)
                                BusSeat(seatNumber: offset + 3, selectedSeatNumber: $viewModel.seatNumber)
                                BusSeat(seatNumber: offset + 4, selectedSeatNumber: $viewModel.seatNumber)
                            }
                        } else {
                            HStack(spacing: 4) {
                                ForEach(0..<5, id: \.self) { index in
                                    let offset = 40 + index
                                    BusSeat(seatNumber: offset + 1, selectedSeatNumber: $viewModel.seatNumber)
                                }
                            }
                        }
                    }
                }
                .padding(.top, 4)
                .padding([.horizontal, .bottom], 18)
                .background(DodamColor.Background.neutral)
                .clipShape(.large)
                HStack {
                    VStack {
                        RoundedRectangle(cornerRadius: 9)
                            .foreground(DodamColor.Line.normal)
                            .frame(width: 12, height: 108)
                            .padding(.top, 48)
                        Spacer()
                        RoundedRectangle(cornerRadius: 9)
                            .foreground(DodamColor.Line.normal)
                            .frame(width: 12, height: 108)
                            .padding(.bottom, 48)
                    }
                    .offset(x: -6)
                    Spacer()
                    VStack {
                        RoundedRectangle(cornerRadius: 9)
                            .foreground(DodamColor.Line.normal)
                            .frame(width: 12, height: 108)
                            .padding(.top, 48)
                        Spacer()
                        RoundedRectangle(cornerRadius: 9)
                            .foreground(DodamColor.Line.normal)
                            .frame(width: 12, height: 108)
                            .padding(.bottom, 48)
                    }
                    .offset(x: 6)
                }
                .zIndex(-1)
            }
            .frame(width: 272)
            .padding(.top, 8)
        }
        .safeAreaInset(edge: .bottom) {
            DodamButton.fullWidth(
                title: "신청"
            ) {
                await viewModel.patchStatus {
                    dialog.present(
                        .init(title: "버스 신청 성공")
                        .primaryButton("닫기") {
                            flow.replace([BusApplyView()])
                        }
                    )
                }
            }
            .disabled(viewModel.seatNumber == nil)
            .padding(.horizontal, 16)
            .padding(.bottom, 12)
        }
    }
}

private struct BusSeat: View {
    let seatNumber: Int
    @Binding var selectedSeatNumber: Int?
    
    private var selected: Bool {
        selectedSeatNumber == seatNumber
    }
    
    var body: some View {
        Button {
            selectedSeatNumber = seatNumber
        } label: {
            Text("\(seatNumber)")
                .body1(.medium)
                .foreground(
                    selected
                    ? DodamColor.Static.white
                    : DodamColor.Label.assistive
                )
                .frame(width: 44, height: 44)
                .background(
                    selected
                    ? DodamColor.Primary.normal
                    : DodamColor.Background.normal
                )
                .clipShape(.rect(cornerRadius: 4))
        }
    }
}
