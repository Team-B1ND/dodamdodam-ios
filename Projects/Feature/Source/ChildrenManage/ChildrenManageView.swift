//
//  ChildrenManageView.swift
//  Feature
//
//  Created by hhhello0507 on 2/4/25.
//

import SwiftUI
import DDS
import FlowKit
import Shared
import Domain

private let relations = ["부", "모", "조부", "조모"]

struct ChildrenManageViewForRegister: View {
    @EnvironmentObject private var viewModel: RegisterViewModel
    @Flow private var flow
    
    var body: some View {
        ContentView(children: $viewModel.connectStudents) {
            flow.replace([
                RegisterInfoView().environmentObject(viewModel)
            ])
        }
    }
}

private struct ContentView: View {
    @StateObject private var viewModel = ChildrenManageViewModel()
    @Binding var children: [ConnectStudent]
    let completion: () -> Void
    @State private var isSheetPresented = false
    
    var body: some View {
        DodamScrollView.medium(
            title: "학생코드로\n자녀를 등록해주세요"
        ) {
            LazyVGrid(columns: [GridItem(), GridItem()], spacing: 12) {
                ForEach(children, id: \.self) { child in
                    ChildCell(child: child)
                }
                Button {
                    isSheetPresented = true
                } label: {
                    VStack(spacing: 8) {
                        Image(icon: .plus)
                            .resizable()
                            .renderingMode(.template)
                            .foreground(DodamColor.Label.assistive)
                            .frame(width: 24, height: 24)
                        Text("자녀 추가 등록")
                            .font(.headline(.bold))
                            .foreground(DodamColor.Label.assistive)
                    }
                    .frame(height: 144)
                    .frame(maxWidth: .infinity)
                    .background(DodamColor.Background.normal)
                    .clipShape(.medium)
                }
            }
            .padding(.horizontal, 16)
            
        }
        .background(DodamColor.Background.neutral)
        .safeAreaInset(edge: .bottom) {
            DodamButton.fullWidth(
                title: "다음"
            ) {
                completion()
            }
            .padding(.bottom, 24)
            .padding(.horizontal, 16)
        }
        .sheet(isPresented: $isSheetPresented) {
            ScrollView {
                VStack(spacing: 16) {
                    VStack(spacing: 8) {
                        HStack {
                            Text("자녀 등록하기")
                                .font(.heading2(.bold))
                                .foreground(DodamColor.Label.normal)
                            Spacer()
                            DodamTextButton.large(
                                title: "등록",
                                color: DodamColor.Primary.normal
                            ) {
                                guard let child = await viewModel.getChild() else { return }
                                children.append(child)
                            }
                        }
                        Text("자녀의 앱에서 '전체 > 내 학생 코드 보기' 탭에서 확인할 수 있어요")
                            .font(.body1(.bold))
                            .foreground(DodamColor.Label.alternative)
                    }
                    DodamTextField.default(
                        title: "학생 코드",
                        text: $viewModel.studentCode
                    )
                    VStack(spacing: 4) {
                        Text("학생과의 관계")
                            .font(.label(.medium))
                            .foreground(DodamColor.Label.assistive)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        ForEach(relations, id: \.self) {
                            RelationCell(
                                selectedRelation: viewModel.relation,
                                relation: $0,
                                isETCMode: viewModel.isETCMode
                            ) { relation in
                                self.viewModel.relation = relation
                                self.viewModel.isETCMode = false
                            }
                        }
                        VStack(spacing: 0) {
                            RelationCell(
                                selectedRelation: viewModel.relation,
                                relation: "기타",
                                isETCMode: viewModel.isETCMode
                            ) { _ in
                                self.viewModel.relation = nil
                                self.viewModel.isETCMode = true
                            }
                            if viewModel.isETCMode {
                                DodamTextField.default(
                                    text: .init {
                                        self.viewModel.relation ?? ""
                                    } set: {
                                        self.viewModel.relation = $0
                                    }
                                )
                            }
                        }
                    }
                }
                .padding(24)
            }
        }
    }
}

private struct ChildCell: View {
    let child: ConnectStudent
    
    var body: some View {
        VStack(spacing: 6) {
            Spacer()
            DodamAvatar.extraLarge(url: "")
            Text("Name")
                .font(.headline(.bold))
            Spacer()
        }
        .frame(height: 144)
        .frame(maxWidth: .infinity)
        .background(DodamColor.Background.normal)
        .clipShape(.medium)
    }
}

private struct RelationCell: View {
    let selectedRelation: String?
    let relation: String
    let isETCMode: Bool
    let action: (_ relation: String) -> Void
    
    var body: some View {
        HStack {
            Text(relation)
                .font(.headline(.medium))
                .foreground(DodamColor.Label.alternative)
            Spacer()
            DodamCheckbox(
                isChecked: .init {
                    (isETCMode && relation == "기타") || relation == selectedRelation
                } set: { _ in
                    action(relation)
                }
            )
        }
    }
}
