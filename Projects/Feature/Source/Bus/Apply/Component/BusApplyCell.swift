//
//  BusApplyCell.swift
//  DodamDodam
//
//  Created by dgsw8th71 on 4/1/24.
//

import SwiftUI
import DDS
import Domain
import Shared

struct BusApplyCell: View {
    private let bus: BusResponse
    private let action: () -> Void
    
    init(bus: BusResponse, action: @escaping () -> Void) {
        self.bus = bus
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(bus.busName)
                    .headline(.medium)
                    .foreground(DodamColor.Label.normal)
                Spacer()
                Text("\(bus.applyCount)/\(bus.peopleLimit)")
                    .headline(.regular)
                    .foreground(DodamColor.Label.alternative)
            }
            .padding(8)
            .opacity(bus.status == .deactivate ? 0.4 : 1)
        }
        .scaledButtonStyle()
        .disabled(bus.applyCount >= bus.peopleLimit || bus.status == .deactivate)
    }
}
