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

struct ChildrenManageView: View {
    @State private var children = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
    @State private var isSheetPresented = false
    @State private var studentCode = ""
    
    var body: some View {
        DodamScrollView.medium(
            title: "학생코드로\n자녀를 등록해주세요"
        ) {
            LazyVGrid(columns: [GridItem(), GridItem()], spacing: 12) {
                ForEach(children, id: \.self) { child in
                    ChildCell()
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
                // 1. request
                // 2. dismiss
            }
            .padding(.bottom, 24)
            .padding(.horizontal, 16)
        }
        .dodamSheet(isPresented: $isSheetPresented) {
            GeometryReader { proxy in
                VStack(spacing: 16) {
                    VStack(spacing: 8) {
                        HStack {
                            Text("자녀 등록하기")
                                .font(.heading2(.bold))
                                .foreground(DodamColor.Label.normal)
                            Spacer()
                            DodamTextButton.large(title: "등록") {
                                // TODO: handle
                            }
                        }
                        Text("자녀의 앱에서 ‘전체 > 내 학생 코드 보기’ 탭에서 확인할 수 있어요")
                            .font(.body1(.bold))
                            .foreground(DodamColor.Label.alternative)
                    }
                    DodamTextField.default(
                        title: "학생 코드",
                        text: $studentCode
                    )
                }
                .frame(height: proxy.size.height * 0.8)
            }
        }
    }
}

private struct ChildCell: View {
    var body: some View {
        VStack(spacing: 12) {
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
