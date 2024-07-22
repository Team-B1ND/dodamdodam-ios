//
//  SettingCell.swift
//  DodamDodam
//
//  Created by hhhello0507 on 7/12/24.
//

import SwiftUI
import DDS

private enum SettingType {
    case description(String)
    case action(() -> Void)
    case link(URL)
}

struct SettingCell: View {
    
    private let text: String
    private let type: SettingType
    private let isDestructive: Bool
    
    private var textColor: DodamColorable {
        isDestructive ? DodamColor.Status.negative : DodamColor.Label.normal
    }
    
    private init(text: String, type: SettingType, isDestructive: Bool = false) {
        self.text = text
        self.type = type
        self.isDestructive = isDestructive
    }
    
    static func description(_ text: String, description: String) -> Self {
        Self.init(text: text, type: .description(description))
    }
    
    static func action(_ text: String, action: @escaping () -> Void) -> Self {
        Self.init(text: text, type: .action(action))
    }
    
    static func link(_ text: String, link: URL) -> Self {
        Self.init(text: text, type: .link(link))
    }
    
    func destructive(_ condition: Bool = true) -> Self {
        return .init(text: text, type: type, isDestructive: condition)
    }
    
    var body: some View {
        switch type {
        case .action(let action):
            Button {
                action()
            } label: {
                content
            }
            .scaledButtonStyle()
        case .link(let url):
            Link(destination: url) {
                content
            }
        default:
            content
        }
    }
    
    @ViewBuilder
    private var content: some View {
        HStack(spacing: 16) {
            Text(text)
                .font(.system(size: 18, weight: .medium))
                .foreground(textColor)
            Spacer()
            if case .description(let string) = type {
                Text(string)
                    .headline(.regular)
                    .foreground(DodamColor.Label.assistive)
            } else {
                Image(icon: .chevronRight)
                    .resizable()
                    .frame(width: 14, height: 14)
                    .foreground(DodamColor.Label.assistive)
            }
        }
        .padding(8)
    }
}
