//
//  DvisionDetailView.swift
//  Feature
//
//  Created by dgsw8th61 on 2/4/25.
//

import SwiftUI
import DDS
import FlowKit
import Domain

struct DivisionDetailView: View {
    @EnvironmentObject private var dialog: DialogProvider
    @StateObject private var viewModel: DivisionDetailViewModel
    @State private var selectedMember: DivisionMemberResponse?
    @State private var isSheetPresented = false
    @Flow var flow

    private let divisionId: Int
    
    init(divisionId: Int) {
        self.divisionId = divisionId
        self._viewModel = StateObject(wrappedValue: DivisionDetailViewModel(divisionId: divisionId))
    }

    var body: some View {
        DodamScrollView.small(title: "") {
            VStack(spacing: 12) {
                headerSection
                if viewModel.division?.myPermission == .admin {
                    actionButtons
                }
                memberListSection
            }
            .padding(.horizontal, 16)
            .padding(.top, 8)
        }
        .safeAreaInset(edge: .bottom) {
            if let division = viewModel.division,
               division.myPermission == nil {
                DodamButton.fullWidth(
                    title: "가입 신청"
                ) {
                    await viewModel.applyMemberDivision(id: divisionId)
                    dialog.present(
                        .init(title: "가입 신청 성공")
                    )
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 12)
            }
        }
        .background(DodamColor.Background.neutral)
        .task {
            await viewModel.onAppear()
        }
        .refreshable {
            await viewModel.onRefresh()
        }
        .sheet(isPresented: Binding(
            get: { isSheetPresented && viewModel.division?.myPermission == .admin },
            set: { isSheetPresented = $0 }
        )) {
            if let member = selectedMember {
                let view = MemberDetailSheetView(member: member, id: divisionId, viewModel: viewModel)
                if #available(iOS 16.0, *) {
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
        .onChange(of: selectedMember) { newValue in
            if viewModel.division?.myPermission == .admin {
                isSheetPresented = newValue != nil
            }
        }
    }

    private var headerSection: some View {
        VStack {
            if let division = viewModel.division {
                HStack {
                    Text(division.divisionName)
                        .heading1(.bold)
                        .foreground(DodamColor.Label.normal)
                    Spacer()
                }
                .padding(.bottom, 4)
                
                Text(division.description)
                    .body1(.medium)
                    .foreground(DodamColor.Label.neutral)
                    .frame(maxWidth: .infinity, alignment: .leading)
            } else {
                DodamLoadingView()
                    .padding(.vertical, 10)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(16)
        .background(DodamColor.Background.normal)
        .cornerRadius(12)
    }

    private var actionButtons: some View {
        HStack {
            Spacer()
            Button {
                if let division = viewModel.division {
                    flow.push(DivisionWaitingMemberView(division: division))
                }
            } label: {
                Text("가입 신청")
                    .headline(.bold)
                    .foreground(DodamColor.Label.strong)
                
                if let members = viewModel.waitingMemberCount, members > 0 {
                    DodamTag(String(members), type: .primary)
                }
            }

            Spacer()

            Rectangle()
                .frame(width: 1, height: 20)
                .foreground(DodamColor.Line.alternative)
            Spacer()
            Button {
                flow.push(DivisionAddMember(id: divisionId))
            } label: {
                Text("멤버 추가")
                    .headline(.bold)
                    .foreground(DodamColor.Label.strong)
            }

            Spacer()
        }
        .padding(16)
        .background(DodamColor.Background.normal)
        .frame(maxWidth: .infinity)
        .cornerRadius(12)
    }

    private var memberListSection: some View {
        VStack(spacing: 16) {
            Text("멤버")
                .heading1(.bold)
                .foreground(DodamColor.Label.normal)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            if viewModel.division == nil {
                DodamLoadingView()
                    .padding(.vertical, 40)
            } else if let divisionMember = viewModel.divisionMember {
                let writers = divisionMember.find(permission: .writer)
                let readers = divisionMember.find(permission: .writer)
                
                // 관리자가 없는 경우는 없음. 무조건 그룹에 한 명이 존재함.
                MemberSection(title: "관리자", members: divisionMember.find(permission: .admin)) {
                    showMemberSheet(member: $0)
                }
                
                if !writers.isEmpty {
                    DodamDivider()
                        .padding(.horizontal, 8)
                    MemberSection(title: "부관리자", members: writers) {
                        showMemberSheet(member: $0)
                    }
                }
                
                if !readers.isEmpty {
                    DodamDivider()
                        .padding(.horizontal, 8)
                    MemberSection(title: "멤버", members: readers) {
                        showMemberSheet(member: $0)
                    }
                }
            }
        }
        .padding(16)
        .background(DodamColor.Background.normal)
        .clipShape(.medium)
    }

    private func showMemberSheet(member: DivisionMemberResponse) {
        if viewModel.division?.myPermission == .admin {
            selectedMember = member
            isSheetPresented = true
        }
    }
    
    private var admins: [DivisionMemberResponse]? {
        viewModel.divisionMember?.find(permission: .admin)
    }

    private var writers: [DivisionMemberResponse]? {
        viewModel.divisionMember?.find(permission: .writer)
    }

    private var readers: [DivisionMemberResponse]? {
        viewModel.divisionMember?.find(permission: .reader)
    }

    private func dynamicHeight(for member: DivisionMemberResponse) -> CGFloat {
        let baseHeight: CGFloat = 300
        let additionalHeight: CGFloat = CGFloat(member.permission.rawValue.count) * 5
        return min(baseHeight + additionalHeight, 600)
    }
}
