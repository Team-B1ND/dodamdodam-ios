//
//  WakeupSongCell.swift
//  DodamDodam
//
//  Created by dgsw8th71 on 4/1/24.
//

import SwiftUI
import DDS

struct TomorrowWakeupSongCell: View {
    
    var rank: Int
    
    var body: some View {
        HStack(spacing: 16) {
            Text("\(rank)")
                .font(.label(.large))
                .dodamColor(.primary)
            Image(.onboard)
                .resizable()
                .frame(width: 120, height: 67)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .padding(.vertical, 8)
            VStack(alignment: .leading, spacing: 2) {
                Text("TWS (투어스) '첫 만남은 계획대로 되")
                    .font(.body(.medium))
                    .dodamColor(.onSurface)
                    .lineLimit(1)
                Text("HYBE LABELS")
                    .font(.label(.large))
                    .dodamColor(.onSurfaceVariant)
                    .lineLimit(1)
            }
            .padding(.vertical, 12)
            Spacer()
        }
    }
}
