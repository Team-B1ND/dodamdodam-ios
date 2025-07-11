//
//  NightStudyStudentCell.swift
//  Feature
//
//  Created by 김은찬 on 7/4/25.
//

import SwiftUI
import DDS
import Domain

struct ApprovedNightStudyStudentCell: View {
    let data: OngoingNightStudyResponse
    let action: () -> Void
    
    public init(data: OngoingNightStudyResponse, action: @escaping () -> Void) {
        self.data = data
        self.action = action
    }
    
    var body: some View {
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
            
            Circle()
                .frame(width: 3, height: 3)
                .foreground(DodamColor.Line.normal)
            
            Text(data.doNeedPhone ? "O" : "X")
                .font(.body1(.medium))
                .foreground(DodamColor.Label.normal)
            
            Spacer()
            
            Button {
                action()
            } label: {
                Text("정지")
                    .font(.body1(.bold))
                    .foreground(DodamColor.Static.white)
                    .padding(8)
                    .padding(.horizontal, 4)
                    .background(DodamColor.Status.negative)
                    .clipShape(.extraSmall)
            }
        }
    }
}
