//
//  BusApplyView.swift
//  DodamDodam
//
//  Created by dgsw8th71 on 4/1/24.
//

import SwiftUI
import DDS

struct BusApplyView: View {
    
    @InjectObject private var viewModel: BusApplyViewModel
    
    var body: some View {
        VStack {
            ForEach(viewModel.bus, id: \.self) { bus in
                Button {
                    
                } label: {
                    HStack {
                        Text(bus.busName)
                            .font(.title(.medium))
                        Text("\(bus.applyCount)/\(bus.peopleLimit)")
                            .font(.title(.medium))
                    }
                }
            }
        }
        .task {
            await viewModel.fetchBuses()
        }
    }
}
