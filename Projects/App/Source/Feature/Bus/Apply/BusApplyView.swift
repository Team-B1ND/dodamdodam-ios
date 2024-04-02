//
//  BusApplyView.swift
//  DodamDodam
//
//  Created by dgsw8th71 on 4/1/24.
//

import SwiftUI
import DDS

struct BusApplyView: View {
    
    @InjectObject var viewModel: BusApplyViewModel
    @Flow var flow
    
    var body: some View {
        ZStack {
            DodamScrollView(navigationBar: .medium(title: "무슨 버스에\n탑승하실건가요?")) {
                VStack(spacing: 12) {
                    ForEach(viewModel.buses, id: \.self) { bus in
                        Button {
                            guard viewModel.selectedBus?.id ?? 0 != bus.id else {
                                viewModel.selectedBus = nil
                                return
                            }
                            viewModel.selectedBus = bus
                        } label: {
                            BusApplyCell(bus: bus, selectedBus: viewModel.selectedBus)
                        }
                        .padding(.horizontal, 16)
                    }
                }
                .padding(.top, 16)
            }
            VStack {
                Spacer()
                DodamButton.fullWidth(
                    title: "확인"
                ) {
                    // action
                    Task {
                        await viewModel.completeBus()
                    }
                }
                .disabled(viewModel.selectedBus == viewModel.appliedBus)
                .padding(.horizontal, 24)
                .padding(.bottom, 8)
            }
        }
        .task {
            await viewModel.fetchBuses()
            await viewModel.fetchAppledBus()
        }
        .alert("현재 탑승할 수 있는 버스가 없습니다", isPresented: $viewModel.showNotFoundBus) {
            Button("확인", role: .none) {
                flow.pop()
            }
        }
        .alert(viewModel.dialogMessage, isPresented: $viewModel.showDialog) {
            Button("확인", role: .none) {}
        }
    }
}