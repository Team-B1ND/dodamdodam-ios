//
//  File.swift
//  Feature
//
//  Created by dgsw8th61 on 2/5/25.
//

import DDS
import SwiftUI
import FlowKit
import Domain
import Shared

struct DivisionAddMember: View {
    @Flow var flow
    @State var memberSearchText: String = ""
    @StateObject private var viewModel = AddMemberViewModel()
    
    @State private var selectedMembers: [Int: [Int: Bool]] = [:]
    @State private var expandedDivisionId: Set<Int> = []
    let id: Int
    
    var filteredDivisions: [DivisionOverviewResponse] {
        if memberSearchText.isEmpty {
            return viewModel.divisions ?? []
        } else {
            return viewModel.divisions?.filter { division in
                let members = viewModel.divisionMembers[division.id] ?? []
                return members.contains { $0.memberName.localizedCaseInsensitiveContains(memberSearchText) }
            } ?? []
        }
    }
    
    var body: some View {
        VStack {
            DodamScrollView.small(title: "멤버 추가") {
                VStack(spacing: 12) {
                    DodamTextField.default(
                        title: "멤버 검색",
                        text: $memberSearchText
                    )
                    
                    if let _ = viewModel.divisions {
                        divisionListView(filteredDivisions)
                    } else {
                        DodamLoadingView()
                            .padding(.vertical, 40)
                    }
                }
                .padding(.horizontal, 16)
            }
            .frame(maxHeight: .infinity)
            
            controlButtons
        }
        .background(DodamColor.Background.neutral)
        .padding(.horizontal, 16)
        .task {
            await viewModel.fetchDivisions()
        }
    }
    
    @ViewBuilder
    private func divisionListView(_ divisions: [DivisionOverviewResponse]) -> some View {
        ForEach(divisions, id: \.id) { division in
            let divisionId = division.id
            let isExpanded = expandedDivisionId.contains(divisionId)

            CustomAccordion(
                title: division.name,
                isExpanded: isExpanded,
                onToggle: {
                    toggleAccordion(for: divisionId)
                    Task {
                        await viewModel.fetchDivisionMembers(divisionId: divisionId)
                    }
                }
            ) {
                let members = viewModel.divisionMembers[divisionId] ?? []
                MemberListView(
                    selectedMembers: Binding(
                        get: { selectedMembers[divisionId, default: [:]] },
                        set: { selectedMembers[divisionId] = $0 }
                    ),
                    members: members.filter { member in
                        memberSearchText.isEmpty || member.memberName.localizedCaseInsensitiveContains(memberSearchText)
                    }
                )
            }
            .task {
                if let index = divisions.firstIndex(where: { $0.id == division.id }),
                   PagingUtil.isLastPage(index: index, pagingInterval: 10, count: divisions.count) {
                    await viewModel.fetchDivisions(lastId: division.id)
                }
            }
        }
    }

    private func toggleAccordion(for divisionId: Int) {
        if expandedDivisionId.contains(divisionId) {
            expandedDivisionId.remove(divisionId)
        } else {
            expandedDivisionId.insert(divisionId)
        }
    }
    
    private var controlButtons: some View {
        HStack(alignment: .center) {
            DodamButton.fullWidth(
                title: "전체 취소"
            ) {
                resetSelectedMembers()
            }
            .role(.assistive)
            .padding(.trailing, 8)
            
//            DodamButton.fullWidth(
//                title: "추가"
//            ) {
//                Task {
//                    let selectedMemberIds: [String] = selectedMembers.flatMap { division in
//                        division.value.filter { $0.value }.map { String($0.key) }
//                    }
//                    
//                    if !selectedMemberIds.isEmpty {
//                        await viewModel.addMembers(id: id, memberId: selectedMemberIds)
//                    }
//                }
//            }
//            .role(.primary)
            //TODO: 이거 커밋할때 [String]으로
        }
        .padding(.top, 55)
        .padding(.bottom, 12)
    }
    
    private func resetSelectedMembers() {
        for key in selectedMembers.keys {
            selectedMembers[key]?.keys.forEach { selectedMembers[key]?[$0] = false }
        }
    }
}
