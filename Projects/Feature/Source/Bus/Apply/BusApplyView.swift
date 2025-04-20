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
        DodamScrollView.small(
            title: "귀가 버스 신청"
        ) {
            Spacer().frame(height: 12)
            VStack(spacing: 16) {
                VStack(spacing: 16) {
                    Text("신청된 버스")
                        .headline(.bold)
                        .foreground(DodamColor.Label.normal)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    if let appliedBus = viewModel.appliedBus {
                        VStack(alignment: .leading, spacing: 16) {
                            VStack(alignment: .leading, spacing: 2) {
                                Text(appliedBus.busName)
                                    .body2(.medium)
                                    .foreground(DodamColor.Label.assistive)
                                HStack(alignment: .bottom, spacing: 4) {
                                    Text("\(appliedBus.leaveTime.remainingTimeText)")
                                        .title3(.medium)
                                        .foreground(DodamColor.Label.normal)
                                    Text("남음")
                                        .label(.medium)
                                        .foreground(DodamColor.Label.alternative)
                                }
                            }
                            .padding(2)
                            DodamButton.fullWidth(
                                title: "QR 태깅"
                            ) {
                                flow.push(BusApplyTagView(busId: appliedBus.id))
                            }
                            .role(.assistive)
                        }
                        .padding(16)
                        .background(DodamColor.Background.normal)
                        .clipShape(.large)
                    } else {
                        Text("신청된 버스가 아직 없어요.")
                            .body1(.medium)
                            .foreground(DodamColor.Label.assistive)
                            .padding(.vertical, 32)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                DodamDivider()
                VStack(spacing: 8) {
                    Text("버스 신청")
                        .body2(.medium)
                        .padding([.leading, .top], 8)
                        .foreground(DodamColor.Label.alternative)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    if let buses = viewModel.buses {
                        LazyVStack(spacing: 16) {
                            ForEach(
                                buses,
                                id: \.id
                            ) { bus in
                                BusApplyCell(bus: bus) {
                                    viewModel.selectedBus = bus
                                }
                            }
                        }
                    } else {
                        DodamLoadingView()
                            .padding(.vertical, 20)
                    }
                }
                .padding(.horizontal, 16)
            }
        }
        .background(DodamColor.Background.neutral)
        // TODO: Improve DDS
        .dodamSheet(isPresented: .init {
            viewModel.selectedBus != nil
        } set: { newValue in
            if !newValue {
                viewModel.selectedBus = nil
            }
        }) {
            if let bus = viewModel.selectedBus {
                VStack(alignment: .leading, spacing: 24) {
                    VStack(alignment: .leading, spacing: 16) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(bus.busName)
                                .heading1(.bold)
                                .foreground(DodamColor.Label.normal)
                            Text(bus.description)
                                .headline(.medium)
                                .foreground(DodamColor.Label.assistive)
                        }
                        VStack(alignment: .leading, spacing: 4) {
                            Text("출발 시간: \(bus.leaveTime.parseString(format: "HH:mm"))")
                                .headline(.medium)
                                .foreground(DodamColor.Label.assistive)
                            Text("소요 시간: \(bus.timeRequired.parseString(format: "HH:mm"))")
                                .headline(.medium)
                                .foreground(DodamColor.Label.assistive)
                            Text("탑승자 수: \(bus.applyCount)/\(bus.peopleLimit)")
                                .headline(.medium)
                                .foreground(DodamColor.Label.assistive)
                        }
                    }
                    DodamButton.fullWidth(
                        title: "버스 신청"
                    ) {
                        flow.push(BusApplySelectSeatView(busId: bus.id))
                    }
                    .disabled(viewModel.selectedBus == viewModel.appliedBus)
                }
                // TODO: Improve DDS
                .padding([.top, .horizontal], -24)
                .padding(16)
            }
        }
        .task {
            await viewModel.onAppear()
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
    }
}
