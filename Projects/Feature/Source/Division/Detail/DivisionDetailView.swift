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
                if viewModel.division == nil {
                    DodamLoadingView()
                        .padding(.vertical, 40)
                } else {
                    headerSection
                    if viewModel.division?.myPermission == .admin {
                        actionButtons
                    }
                    memberListSection
                }
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
                if #available(iOS 16.0, *) {
                    MemberDetailSheetView(member: member, id: divisionId)
                        .presentationDragIndicator(.visible)
                        .presentationDetents([.height(dynamicHeight(for: member))])
                } else {
                    MemberDetailSheetView(member: member, id: divisionId)
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
        .padding(16)
        .background(DodamColor.Background.normal)
        .cornerRadius(12)
    }

    private var actionButtons: some View {
        HStack {
            Spacer()
            Button {
                flow.push(DivisionWaitingMemberView(divisionId: divisionId, group: viewModel.division!.divisionName))
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
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("멤버")
                    .heading1(.bold)
                    .foreground(DodamColor.Label.normal)
                Spacer()
            }
            .padding(.bottom, 4)

            if !admins.isEmpty {
                MemberSection(title: "관리자", members: admins, onSelect: { showMemberSheet(member: $0) }, showDivider: !writers.isEmpty || !readers.isEmpty)
            }

            if !writers.isEmpty {
                MemberSection(title: "부관리자", members: writers, onSelect: { showMemberSheet(member: $0) }, showDivider: !readers.isEmpty)
            }

            if !readers.isEmpty {
                MemberSection(title: "멤버", members: readers, onSelect: { showMemberSheet(member: $0) }, showDivider: false)
            }
        }
        .padding(16)
        .background(DodamColor.Background.normal)
        .cornerRadius(12)
    }

    private func showMemberSheet(member: DivisionMemberResponse) {
        if viewModel.division?.myPermission == .admin {
            selectedMember = member
            isSheetPresented = true
        }
    }
    
    private var admins: [DivisionMemberResponse] {
        viewModel.divisionMember?.filter { $0.permission == .admin } ?? []
    }

    private var writers: [DivisionMemberResponse] {
        viewModel.divisionMember?.filter { $0.permission == .writer } ?? []
    }

    private var readers: [DivisionMemberResponse] {
        viewModel.divisionMember?.filter { $0.permission == .reader } ?? []
    }

    private func dynamicHeight(for member: DivisionMemberResponse) -> CGFloat {
        let baseHeight: CGFloat = 300
        let additionalHeight: CGFloat = CGFloat(member.permission.rawValue.count) * 5
        return min(baseHeight + additionalHeight, 600)
    }
}
