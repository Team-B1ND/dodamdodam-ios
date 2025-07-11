//
//  PendingStudentInfoHeader.swift
//  Feature
//
//  Created by 김은찬 on 7/7/25.
//

import SwiftUI
import DDS

struct PendingStudentInfoHeader: View {
    var body: some View {
        HStack(spacing: 16) {
            Text("이름")
                .font(.body1(.medium))
                .foreground(DodamColor.Label.normal)
            
            Circle()
                .frame(width: 3, height: 3)
                .foreground(DodamColor.Line.normal)
            Text("학번")
                .font(.body1(.medium))
                .foreground(DodamColor.Label.normal)
            
            Spacer()
        }
        .padding(.horizontal)
    }
}

#Preview {
    PendingStudentInfoHeader()
}
