//
//  BusApplyView.swift
//  DodamDodam
//
//  Created by dgsw8th71 on 4/1/24.
//

import SwiftUI
import DDS
import FlowKit
import Shared

struct BusApplyView: View {
    
    @DodamDialog private var dialog
    @StateObject var viewModel = BusApplyViewModel()
    @Flow var flow
    
    var body: some View {
        DodamScrollView.medium(title: "무슨 버스에\n탑승하실건가요?") {
            VStack(spacing: 12) {
                ForEach(
                    viewModel.buses,
                    id: \.self
                ) { bus in
                    Button {
                        if viewModel.selectedBus?.id == bus.id {
                            viewModel.selectedBus = nil
                        } else {
                            viewModel.selectedBus = bus
                        }
                    } label: {
                        BusApplyCell(bus: bus, selectedBus: viewModel.selectedBus)
                    }
                    .scaledButtonStyle()
                    .disabled(bus.applyCount >= bus.peopleLimit)
                }
            }
            .padding([.top, .horizontal], 16)
        }
        .overlay(alignment: .bottom) {
            DodamButton.fullWidth(
                title: "확인"
            ) {
                Task {
                    await viewModel.completeBus()
                }
            }
            .disabled(viewModel.selectedBus == viewModel.appliedBus)
            .padding([.bottom, .horizontal], 16)
        }
        .task {
            async let fetchBuses: () = viewModel.fetchBuses()
            async let fetchAppledBus: () = viewModel.fetchAppledBus()
            _ = await [fetchBuses, fetchAppledBus]
        }
        .onChange(of: viewModel.showNotFoundBus) {
            if $0 {
                let dialog = Dialog(title: "현재 탑승할 수 있는 버스가 없습니다")
                    .primaryButton("확인") {
                        flow.pop()
                    }
                self.dialog.present(dialog)
            }
        }
        .onChange(of: viewModel.dialogMessage) {
            let dialog = Dialog(title: $0)
                .primaryButton("확인") {
                    flow.pop()
                }
            self.dialog.present(dialog)
        }
    }
}
