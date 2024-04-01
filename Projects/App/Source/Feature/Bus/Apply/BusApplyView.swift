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
                VStack {
                    ForEach(viewModel.buses, id: \.self) { bus in
                        Button {
                            guard viewModel.selectedBus?.id ?? 0 != bus.id else {
                                viewModel.selectedBus = nil
                                return
                            }
                            viewModel.selectedBus = bus
                        } label: {
                            HStack {
                                Text(bus.busName)
                                    .font(.title(.medium))
                                    .dodamColor(.tertiary)
                                Spacer()
                                Text("\(bus.applyCount)/\(bus.peopleLimit)")
                                    .font(.title(.medium))
                                    .dodamColor(bus.applyCount >= bus.peopleLimit ? .error : .primary)
                                
                                let myBus = bus.id == viewModel.selectedBus?.id ?? 0
                                Image(icon: .checkmark)
                                    .resizable()
                                    .frame(width: 32, height: 32)
                                    .opacity(myBus ? 1 : 0)
                            }
                        }
                        .padding(.horizontal, 16)
                    }
                }
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
                .disabled(viewModel.selectedBus == nil)
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
//        .dodamModal(isPresented: $showNotFoundBus) {
//            Text("현재 탑승할 수 있는 버스가 없습니다")
//                .font(.title(.large))
//                .dodamColor(.onSurface)
//        }
    }
}
