//
//  NightProjectApplyView.swift
//  Feature
//
//  Created by dgsw30 on 4/17/25.
//

import SwiftUI
import DDS
import Shared
import FlowKit
import Domain

struct NightProjectApplyView: View {
    @DodamDatePicker private var datePicker
    @DodamDialog private var dialog
    @ObservedObject var viewModel: NightProjectApplyViewModel
    @Flow var flow
    @FocusState var focused
    
    @State private var test = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            VStack(spacing: 14) {
                DodamTextField.default(
                    title: "프로젝트명",
                    text: $viewModel.projectName
                )
                .makeFirstResponder()
                .padding(.horizontal, 8)
                .focused($focused)
                .hideKeyboardWhenTap()
                
                DodamTextField.default(
                    title: "프로젝트 개요",
                    text: $viewModel.projectDescription
                )
                .padding(.horizontal, 8)
                .hideKeyboardWhenTap()
            }
            
            VStack(spacing: 16) {
                HStack(spacing: 16) {
                    Text("자습 장소")
                        .headline(.medium)
                        .font(.system(size: 18, weight: .medium))
                        .foreground(DodamColor.Label.alternative)
                    Spacer()
                    Menu {
                        Picker(
                            "시작 날짜",
                            selection: $viewModel.place,
                            content: {
                                ForEach(
                                    NightProjectPlace.allCases,
                                    id: \.self
                                ) { place in
                                    Text(place.rawValue)
                                }
                            }
                        )
                    } label: {
                        HStack(spacing: 4) {
                            Text("\(viewModel.place.rawValue)")
                                .headline(.regular)
                                .foreground(DodamColor.Primary.normal)
                            VStack(spacing: -4) {
                                Image(icon: .chevronLeft)
                                    .resizable()
                                    .frame(width: 12, height: 12)
                                    .rotationEffect(.degrees(90))
                                Image(icon: .chevronLeft)
                                    .resizable()
                                    .frame(width: 12, height: 12)
                                    .rotationEffect(.degrees(-90))
                            }
                        }
                    }
                }
                .padding(.horizontal, 8)
                .frame(height: 40)
                
                Button {
                    let datePicker = DatePicker(
                        title: "종료 날짜",
                        startDate: viewModel.startAt,
                        endDate: Calendar.current.date(byAdding: .day, value: 30, to: viewModel.startAt) ?? .now
                    ) {
                        viewModel.endAt = self.datePicker.date
                    }
                    self.datePicker.present(datePicker, date: viewModel.endAt, monthDate: viewModel.endAt)
                    focused = false
                } label: {
                    HStack(spacing: 12) {
                        Text("종료 날짜")
                            .font(.system(size: 18, weight: .medium))
                            .foreground(DodamColor.Label.alternative)
                        Spacer()
                        Text(
                            viewModel.endAt.parseString(
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
                
                HStack {
                    DodamTextField.default(
                        title: "학생 검색",
                        text: $test
                    )
                    .padding(.vertical, 8)
                    .padding(.top, -8)
                    .padding(.bottom, 8)
                    
                    Button {
                        print("검색 구현해야함")
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .foreground(DodamColor.Label.assistive)
                    }
                    
                }
                .padding(.horizontal, 8)
            }
        }
    }
}
