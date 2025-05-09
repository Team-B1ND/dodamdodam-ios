//
//  DodamStudentCell.swift
//  Feature
//
//  Created by dgsw30 on 5/6/25.
//

import SwiftUI
import DDS
import Domain
import CachedAsyncImage

struct DodamStudentCell: View {
    let student: NightStudyStudentResponse
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack(spacing: 10) {
                DodamAvatar.medium(url: student.profileImage)
                    .padding(.horizontal, 4)
                
                VStack(alignment: .leading) {
                    Text("\(student.name)")
                    Text("\(student.grade)\(student.room)\(String(format: "%02d", student.number))")
                }
                .font(.body2(.medium))
                .foreground(DodamColor.Label.alternative)
                
                Spacer()
                
                if isSelected {
                    Image(icon: .checkCircle)
                }
            }
        }
    }
}
