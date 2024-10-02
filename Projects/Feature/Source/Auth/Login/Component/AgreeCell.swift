//
//  AgreeCell.swift
//  Feature
//
//  Created by hhhello0507 on 9/17/24.
//

import SwiftUI
import DDS
import Shared

struct AgreeCell: View {
    
    @Environment(\.openURL) private var openURL
    
    private let isChecked: Bool
    private let description: String
    private let url: String
    private let action: () -> Void
    
    init(isChecked: Bool, description: String, url: String, action: @escaping () -> Void) {
        self.isChecked = isChecked
        self.description = description
        self.url = url
        self.action = action
    }
    
    var body: some View {
        HStack(spacing: 12) {
            Button {
                action()
            } label: {
                HStack(spacing: 12) {
                    Dodam.icon(.checkmark)
                        .resizable()
                        .frame(width: 16, height: 16)
                        .foreground(
                            isChecked
                            ? DodamColor.Primary.normal
                            : DodamColor.Label.alternative
                        )
                        .opacity(
                            isChecked
                            ? 1
                            : 0.5
                        )
                    Text(description)
                        .label(.regular)
                        .foreground(DodamColor.Label.assistive)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(4)
            }
            .scaledButtonStyle()
            Button {
                openURL.callAsFunction(URL(string: url)!)
            } label: {
                Text("보기")
                    .underline()
                    .label(.bold)
                    .foreground(DodamColor.Label.assistive)
            }
            .scaledButtonStyle()
        }
        .frame(height: 32)
    }
}
