//
//  PendingNightStudyStudentCell.swift
//  Feature
//
//  Created by 김은찬 on 7/7/25.
//

import SwiftUI
import DDS
import Domain

struct PendingNightStudyStudentCell: View {
    let data: OngoingNightStudyResponse
    let isSelected: Bool
    let action: () -> Void
    
    init(data: OngoingNightStudyResponse, isSelected: Bool, action: @escaping () -> Void) {
        self.data = data
        self.isSelected = isSelected
        self.action = action
    }
    
    var body: some View {
        Button {
            withAnimation {
                action()
            }
        } label: {
            HStack(spacing: 16) {
                Group {
                    Image(icon: .person)
                        .resizable()
                        .renderingMode(.template)
                        .foreground(DodamColor.Fill.alternative)
                        .frame(width: 25, height: 25)
                }
                .frame(width: 35, height: 35)
                .background(DodamColor.Fill.normal)
                .clipShape(Circle())
                
                Text(data.student.name)
                    .font(.body1(.medium))
                    .foreground(DodamColor.Label.normal)
                
                Circle()
                    .frame(width: 3, height: 3)
                    .foreground(DodamColor.Line.normal)
                
                Text("\(data.student.grade)\(data.student.room)\(String(format: "%02d", data.student.number))")
                    .font(.body1(.medium))
                    .foreground(DodamColor.Label.normal)
                
                Spacer()
                
                if isSelected {
                    Image(icon: .checkCircle)
                }
            }
        }
    }
}
