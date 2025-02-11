//
//  DvisionDetailView.swift
//  Feature
//
//  Created by dgsw8th61 on 2/4/25.
//

import SwiftUI
import DDS
import FlowKit

struct DivisionDetailView: View {
    @StateObject private var viewModel = DivisionDetailViewModel()
    @State private var selectedMember: Member?
    @State private var isSheetPresented = false
    @Flow var flow

    let divisionId: Int

    var body: some View {
        ZStack {
            DodamScrollView.small(title: "") {
                VStack {
                    headerSection
                    if viewModel.division?.myPermission == .admin {
                        actionButtons
                    }
                    memberListSection
                }
            }
            if viewModel.division?.myPermission == nil {
                VStack {
                    Spacer()
                    DodamButton.fullWidth(
                        title: "가입신청"
                    ) {
                        await viewModel.applyMemberDivision(id: divisionId)
                    }
                    .padding(.horizontal, 16)
                }
            }
        }
        .background(DodamColor.Background.neutral)
        .task {
            await viewModel.fetchAllData(id: divisionId)
        }
        .refreshable {
            await viewModel.fetchAllData(id: divisionId)
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
            HStack {
                Text(viewModel.division?.divisionName ?? "없음")
                    .heading1(.bold)
                    .foreground(DodamColor.Label.normal)
                Spacer()
                Image(icon: .menu)
                    .resizable()
                    .frame(width: 18, height: 18)
                    .foreground(DodamColor.Label.assistive)
            }
            .padding(.bottom, 4)

            Text(viewModel.division?.description ?? "없음")
                .body1(.medium)
                .foreground(DodamColor.Label.neutral)
        }
        .padding(16)
        .background(DodamColor.Background.normal)
        .cornerRadius(12)
        .padding(.horizontal, 16)
        .padding(.top, 8)
    }

    private var actionButtons: some View {
        HStack {
            Spacer()
            Button {
                flow.push(DivisionWaitingMemberView(divisionId: divisionId))
            } label: {
                Text("가입 신청")
                    .headline(.bold)
                    .foreground(DodamColor.Label.strong)

                Text("12")
                    .font(.system(size: 16, weight: .bold))
                    .foreground(DodamColor.Static.white)
                    .padding(.vertical, 2)
                    .padding(.horizontal, 8)
                    .background(DodamColor.Primary.normal)
                    .cornerRadius(30)
                    .padding(.leading, 8)
            }

            Spacer()

            Rectangle()
                .frame(width: 1, height: 20)
                .foreground(DodamColor.Line.alternative)
            Spacer()
            Button {
                flow.push(DivisionAddMember())
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
        .padding(.horizontal, 16)
        .padding(.top, 8)
    }

    private var memberListSection: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("멤버")
                    .heading1(.bold)
                    .foreground(DodamColor.Label.normal)
                Spacer()
            }
            .padding(.bottom, 4)

            if !admins.isEmpty {
                MemberSection(title: "관리자", members: admins, onSelect: { showMemberSheet(member: $0) }, showDivider: !writers.isEmpty)
            }

            if !writers.isEmpty {
                MemberSection(title: "부관리자", members: writers, onSelect: { showMemberSheet(member: $0) }, showDivider: !readers.isEmpty)
            }

            if !readers.isEmpty {
                MemberSection(title: "멤버", members: readers, onSelect: { showMemberSheet(member: $0) }, showDivider: !writers.isEmpty)
            }
        }
        .padding(16)
        .background(DodamColor.Background.normal)
        .cornerRadius(12)
        .padding(.horizontal, 16)
        .padding(.top, 8)
    }

    private var members: [Member] {
        viewModel.divisionMember?.map {
            Member(
                id: $0.id,
                name: $0.memberName,
                role: $0.permission.rawValue,
                imageUrl: $0.profileImage,
                grade: $0.grade,
                room: $0.room,
                number: $0.number
            )
        } ?? []
    }

    private var admins: [Member] {
        members.filter { $0.role == "ADMIN" }
    }

    private var writers: [Member] {
        members.filter { $0.role == "WRITER" }
    }

    private var readers: [Member] {
        members.filter { $0.role == "READER" }
    }

    private func showMemberSheet(member: Member) {
        if viewModel.division?.myPermission == .admin {
            selectedMember = member
            isSheetPresented = true
        }
    }

    private func dynamicHeight(for member: Member) -> CGFloat {
        let baseHeight: CGFloat = 300
        let additionalHeight: CGFloat = CGFloat(member.role?.count ?? 0) * 5
        return min(baseHeight + additionalHeight, 600)
    }
}
