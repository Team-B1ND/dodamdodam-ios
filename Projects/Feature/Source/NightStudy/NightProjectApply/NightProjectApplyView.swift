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
                        Text(
                            viewModel.startAt.parseString(
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
                
                Button {
                    let datePicker = DatePicker(
                        title: "종료 날짜",
                        startDate: viewModel.startAt,
                        endDate: Calendar.current.date(byAdding: .day, value: 13, to: viewModel.startAt) ?? .now
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
            }
            
            VStack(alignment: .leading, spacing: 16) {
                Text("프로젝트 타입")
                    .headline(.medium)
                    .padding(.horizontal, 8)
                
                Picker("프로젝트 타입", selection: $viewModel.projectType) {
                    ForEach(NightStudyProjectType.allCases, id: \.self) { type in
                        Text(type.rawValue)
                            .tag(type)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal, 8)
            }
            
            VStack(alignment: .leading, spacing: 16) {
                Text("실습실")
                    .headline(.medium)
                    .padding(.horizontal, 8)
                
                Picker("실습실", selection: $viewModel.room) {
                    ForEach(NightProjectPlace.allCases, id: \.self) { room in
                        Text(room.rawValue)
                            .tag(room)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal, 8)
            }
            
            VStack(alignment: .leading, spacing: 16) {
                Text("참여 학생")
                    .headline(.medium)
                    .padding(.horizontal, 8)
                
                DodamTextField.default(
                    title: "학생 검색",
                    text: $viewModel.searchText
                )
                .padding(.horizontal, 8)
                .onChange(of: viewModel.searchText) { _ in
                    Task {
                        await viewModel.searchStudents(query: viewModel.searchText)
                    }
                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(viewModel.searchResults, id: \.id) { student in
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
                .frame(height: 40)
            }
            
            Spacer()
            
            Button {
                Task {
                    await viewModel.postNightStudyProject()
                    flow.pop()
                }
            } label: {
                Text("신청하기")
                    .font(.system(size: 16, weight: .bold))
                    .foreground(DodamColor.Label.normal)
                    .frame(maxWidth: .infinity)
                    .frame(height: 48)
                    .background(
                        viewModel.projectName.isEmpty ||
                        viewModel.projectDescription.count < 10 ||
                        viewModel.selectedStudents.isEmpty ?
                        DodamColor.Label.alternative :
                        DodamColor.Primary.normal
                    )
                    .cornerRadius(8)
            }
            .opacity(
                viewModel.projectName.isEmpty ||
                viewModel.projectDescription.count < 10 ||
                viewModel.selectedStudents.isEmpty ? 0.3 : 1
            )
            .padding(.horizontal, 8)
            .padding(.bottom, 16)
        }
        .navigationTitle("프로젝트 심자 신청")
        .navigationBarTitleDisplayMode(.inline)
        .alert(
            "프로젝트 심자 신청 실패",
            isPresented: $viewModel.nightStudyApplyFailed,
            actions: {
                Button("확인", role: .cancel) {}
            }, message: {
                Text(viewModel.nightStudyApplyAlertMessage)
            }
        )
    }
}

struct DodamStudentCell: View {
    let student: NightStudyStudentResponse
    let isSelected: Bool
    
    var body: some View {
        HStack(spacing: 4) {
            Text("\(student.grade)\(student.room)\(String(format: "%02d", student.number))")
                .font(.system(size: 14, weight: .regular))
            Text(student.name)
                .font(.system(size: 14, weight: .regular))
        }
        .padding(.horizontal, 12)
        .frame(height: 40)
        .background(isSelected ? DodamColor.Primary.normal : DodamColor.Background.alternative)
        .foreground(isSelected ? DodamColor.Label.strong : DodamColor.Label.normal)
        .cornerRadius(20)
    }
}
