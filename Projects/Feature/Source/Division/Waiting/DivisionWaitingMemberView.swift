//
//  DivisionWaitingMemberView.swift
//  Feature
//
//  Created by dgsw8th61 on 2/5/25.
//

import DDS
import SwiftUI
import Domain

struct DivisionWaitingMemberView: View {
    @State private var selectedMember: DivisionMemberResponse?
    @State private var isSheetPresented = false
    @StateObject private var viewModel: DivisionWaitingViewModel
    
    private let division: DivisionDetailResponse
    
    init(division: DivisionDetailResponse) {
        self.division = division
        self._viewModel = StateObject(wrappedValue: DivisionWaitingViewModel(divisionId: division.id))
    }
    
    var body: some View {
        DodamScrollView.medium(
            title: "\(division.divisionName) 그룹\n가입 신청 대기 중인 멤버"
        ) {
            Group {
                if let divisionMember = viewModel.divisionMember {
                    if divisionMember.isEmpty {
                        Text("대기 중인 멤버가 없습니다.")
                            .body1(.medium)
                            .foreground(DodamColor.Label.assistive)
                            .padding()
                    } else {
                        MemberSection(
                            title: "가입 신청 멤버",
                            members: viewModel.divisionMember ?? [],
                            onSelect: showMemberSheet
                        )
                    }
                } else {
                    DodamLoadingView()
                        .padding(.vertical, 20)
                }
            }
            .padding(16)
        }
        .refreshable {
            await viewModel.onRefresh()
        }
        .task {
            await viewModel.onAppear()
        }
        .onChange(of: selectedMember) { newValue in
            isSheetPresented = newValue != nil
        }
        .sheet(isPresented: $isSheetPresented) {
            if let member = selectedMember {
                let view = WaitingMemberSheetView(member: member, id: division.id, viewModel: viewModel)
                if #available(iOS 16.4, *) {
                    view
                        .presentationDragIndicator(.visible)
                        .presentationDetents([.height(dynamicHeight(for: member))])
                } else {
                    view
                }
            } else {
                Text("멤버 정보를 불러올 수 없습니다.")
            }
        }
        .background(DodamColor.Background.normal)
    }

    private func showMemberSheet(member: DivisionMemberResponse) {
        selectedMember = member
        isSheetPresented = true
    }

    private func dynamicHeight(for member: DivisionMemberResponse) -> CGFloat {
        let baseHeight: CGFloat = 210
        let additionalHeight: CGFloat = CGFloat(member.permission.rawValue.count) * 5
        return min(baseHeight + additionalHeight, 600)
    }
}
