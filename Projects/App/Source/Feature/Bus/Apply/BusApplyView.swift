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
                            
                        } label: {
                            HStack {
                                Text(bus.busName)
                                    .font(.title(.medium))
                                    .dodamColor(.tertiary)
                                Spacer()
                                Text("\(bus.applyCount)/\(bus.peopleLimit)")
                                    .font(.title(.medium))
                                    .dodamColor(bus.applyCount >= bus.peopleLimit ? .error : .primary)
                                
                                let myBus = bus.id == viewModel.appliedBus?.id ?? 0
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
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 8)
            }
        }
        .task {
            await viewModel.fetchBuses()
        }
    }
}
