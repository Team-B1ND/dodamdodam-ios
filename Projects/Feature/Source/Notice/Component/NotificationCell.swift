//
//  NotificationCell.swift
//  Feature
//
//  Created by dgsw8th61 on 11/5/24.
//

import SwiftUI
import DDS
import Shared

struct NotificationCell: View {
    private let title: String
    private let content: String
    private let user: String
    private let date: String
    init(
        title: String,
        content: String,
        user: String,
        date: String
    ) {
        self.title = title
        self.content = content
        self.user = user
        self.date = date
    }
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("\(user) · \(date)")
                        .font(.system(size: 14, weight: .regular))
                        .foreground(DodamColor.Label.assistive)
                }
                Text(title)
                    .font(.heading2(.bold))
                    .foreground(DodamColor.Label.normal)
                
                Text(content)
                    .font(.system(size: 14, weight: .regular))
                    .foreground(DodamColor.Label.normal)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(16)
        .background(DodamColor.Background.normal)
        .cornerRadius(18)

    }
}
