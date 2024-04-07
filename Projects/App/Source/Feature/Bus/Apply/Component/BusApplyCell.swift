//
//  BusApplyCell.swift
//  DodamDodam
//
//  Created by dgsw8th71 on 4/1/24.
//

import SwiftUI
import DDS

struct BusApplyCell: View {
    
    let bus: BusResponse
    let selectedBus: BusResponse?
    
    var body: some View {
        HStack {
            Text(bus.busName)
                .font(.title(.medium))
                .fontWeight(.medium)
                .dodamColor(.tertiary)
            Spacer()
            Text("\(bus.applyCount)/\(bus.peopleLimit)")
                .font(.title(.medium))
                .fontWeight(.regular)
                .dodamColor(
                    bus.applyCount >= bus.peopleLimit ? .error
                    : bus.id == selectedBus?.id ? .primary : .tertiary
                )
            if bus.id == selectedBus?.id ?? 0 {
                Image(icon: .checkmark)
                    .resizable()
                    .frame(width: 32, height: 32)
                    .dodamColor(.primary)
            }
        }
        .frame(height: 40)
        .padding(.horizontal, 8)
    }
}
