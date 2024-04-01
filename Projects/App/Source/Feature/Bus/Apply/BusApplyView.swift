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
        DodamScrollView(navigationBar: .medium(title: "무슨 버스에\n탑승하실건가요?")) {
            VStack {
                ForEach(viewModel.bus, id: \.self) { bus in
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
                        }
                    }
                    .padding(.horizontal, 16)
                }
            }
        }
        .task {
            await viewModel.fetchBuses()
        }
    }
}
