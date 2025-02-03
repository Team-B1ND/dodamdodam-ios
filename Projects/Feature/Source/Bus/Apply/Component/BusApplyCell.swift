//
//  BusApplyCell.swift
//  DodamDodam
//
//  Created by dgsw8th71 on 4/1/24.
//

import SwiftUI
import DDS
import Domain

struct BusApplyCell: View {
    
    let bus: BusResponse
    let selectedBus: BusResponse?
    
    var body: some View {
        HStack {
            Text(bus.busName)
                .headline(.medium)
                .foreground(DodamColor.Label.normal)
            Spacer()
            Text("\(bus.applyCount)/\(bus.peopleLimit)")
                .headline(.regular)
                .foreground(
                    bus.applyCount >= bus.peopleLimit ? DodamColor.Status.negative
                    : bus.id == selectedBus?.id ? DodamColor.Primary.normal as DodamColorable : DodamColor.Label.alternative
                )
            if bus.id == selectedBus?.id ?? 0 {
                Image(icon: .checkmark)
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foreground(DodamColor.Primary.normal)
            }
        }
        .frame(height: 40)
        .padding(.horizontal, 8)
        .animation(.spring(duration: 0.2), value: selectedBus)
    }
}
