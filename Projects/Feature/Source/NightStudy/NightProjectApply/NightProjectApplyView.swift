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
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
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
            .padding(.bottom, 22)
            .padding(.horizontal, 8)
            .hideKeyboardWhenTap()
            .overlay(alignment: .bottomLeading) {
                if viewModel.projectDescription.count < 10 {
                    Text("10글자 이상 입력하세요")
                        .font(.system(size: 14, weight: .regular))
                        .foreground(DodamColor.Status.negative)
                        .padding(.horizontal, 8)
                }
            }
            
            VStack(spacing: 16) {
                HStack(spacing: 16) {
                    Text("진행 시각")
                        .headline(.medium)
                        .font(.system(size: 18, weight: .medium))
                        .foreground(DodamColor.Label.alternative)
                    Spacer()
                    Menu {
                        Picker("시작 날짜", selection: $viewModel.projectType) {
                            ForEach(NightStudyProjectType.allCases, id: \.self) { place in
                                Text(place.displayName)
                            }
                        }
                    } label: {
                        HStack(spacing: 4) {
                            Text(viewModel.projectType.displayName)
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
                
                HStack(spacing: 16) {
                    Text("학습 장소")
                        .headline(.medium)
                        .font(.system(size: 18, weight: .medium))
                        .foreground(DodamColor.Label.alternative)
                    Spacer()
                    Menu {
                        Picker("시작 날짜", selection: $viewModel.room) {
                            ForEach(NightProjectPlace.allCases, id: \.self) { place in
                                Text(place.displayName)
                            }
                        }
                    } label: {
                        HStack(spacing: 4) {
                            Text(viewModel.room.displayName)
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
                        title: "시작 날짜",
                        startDate: .now,
                        endDate: Calendar.current.date(byAdding: .day, value: 0, to: self.datePicker.date.addingTimeInterval(.infinity)) ?? .now
                    ) {
                        viewModel.startAt = self.datePicker.date
                    }
                    self.datePicker.present(datePicker, date: viewModel.startAt, monthDate: viewModel.startAt)
                    focused = false
                } label: {
                    HStack(spacing: 12) {
                        Text("시작 날짜")
                            .font(.system(size: 18, weight: .medium))
                            .foreground(DodamColor.Label.alternative)
                            .headline(.medium)
                        Spacer()
                        Text(viewModel.startAt.parseString(format: "M월 d일"))
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
                
                Button {
                    let datePicker = DatePicker(
                        title: "종료 날짜",
                        startDate: viewModel.startAt,
                        endDate: Calendar.current.date(byAdding: .day, value: 21, to: viewModel.startAt) ?? .now
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
                            .headline(.medium)
                        Spacer()
                        Text(viewModel.endAt.parseString(format: "M월 d일"))
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
            }
            
            VStack(alignment: .leading, spacing: 16) {
                Text("참여 학생")
                    .headline(.medium)
                    .font(.system(size: 18, weight: .medium))
                    .foreground(DodamColor.Label.alternative)
                    .padding(.horizontal, 8)
                    .frame(height: 40)
                
                HStack {
                    DodamTextField.default(
                        title: "학생 검색",
                        text: $viewModel.searchText
                    )
                    .onSubmit {
                        Task {
                            await viewModel.searchStudents()
                        }
                    }
                    .padding(.horizontal, 8)
                    Button {
                        Task {
                            await viewModel.searchStudents()
                        }
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foreground(DodamColor.Label.assistive)
                    }
                }
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 8) {
                        ForEach(viewModel.filteredResults, id: \.id) { student in
                            DodamStudentCell(
                                student: student,
                                isSelected: viewModel.selectedStudents.contains(student.id)
                            )
                            .onTapGesture {
                                viewModel.toggleStudent(student.id)
                            }
                        }
                    }
                    .padding(.horizontal, 8)
                }
            }
        }
    }
}
