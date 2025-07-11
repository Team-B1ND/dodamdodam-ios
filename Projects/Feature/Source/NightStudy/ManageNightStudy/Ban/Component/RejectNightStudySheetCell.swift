//
//  RejectSheetCell.swift
//  Feature
//
//  Created by 김은찬 on 7/8/25.
//

import SwiftUI
import DDS
import Domain
import Shared

struct RejectNightStudySheetCell: View {
    
    @DodamDatePicker private var datePicker
    let data: OngoingNightStudyResponse
    @Binding var selectedDate: Date?
    @Binding var reasonBanText: String
    let ban: () -> Void
    let cancel: () -> Void
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Text("\(data.student.name)님의 심야 자습 정보")
                    .font(.heading1(.bold))
                    .foreground(DodamColor.Label.normal)
                
                Spacer()
            }
            
            Button {
                let datePicker = DatePicker(
                    title: "종료 날짜",
                    startDate: Date(),
                    endDate: Calendar.current.date(byAdding: .day, value: 30, to: Date()) ?? Date()
                ) {
                    selectedDate = self.datePicker.date
                }
                self.datePicker.present(datePicker, date: selectedDate ?? Date(), monthDate: selectedDate ?? Date())
            } label: {
                HStack(spacing: 12) {
                    Text("종료 날짜")
                        .font(.system(size: 18, weight: .medium))
                        .foreground(DodamColor.Label.alternative)
                        .headline(.medium)
                    Spacer()
                    Text(
                        (selectedDate ?? Date()).parseString(
                            format: "M월 d일"
                        )
                    )
                    .headline(.regular)
                    .font(.system(size: 18, weight: .regular))
                    .foreground(DodamColor.Primary.normal)
                    Image(icon: .calendar)
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foreground(DodamColor.Primary.normal)
                }
                .padding(.horizontal, 8)
                .frame(height: 40)
            }
            .scaledButtonStyle()
            
            DodamTextField.default(
                title: "정지 사유",
                text: $reasonBanText
            )
            .padding(.horizontal, 8)
            
            HStack(spacing: 8) {
                DodamButton.fullWidth(
                    title: "취소"
                ) {
                    cancel()
                }
                .role(.assistive)
                .frame(maxWidth: UIScreen.main.bounds.width * 0.3)
                
                DodamButton.fullWidth(
                    title: "심자정지"
                ) {
                    ban()
                }
                .disabled(reasonBanText.isEmpty)
                .frame(maxWidth: UIScreen.main.bounds.width * 0.6)
            }
            .padding(.top, 24)
            .frame(maxWidth: .infinity)
        }
    }
}
