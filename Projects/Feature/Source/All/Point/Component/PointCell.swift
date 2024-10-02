//
//  PointCell.swift
//  DodamDodam
//
//  Created by hhhello0507 on 7/20/24.
//

import SwiftUI
import DDS
import Domain

struct PointCell: View {
    
    private let point: PointResponse
    
    init(point: PointResponse) {
        self.point = point
    }
    
    public var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 0) {
                Text("\(point.reason.reason)")
                    .headline(.bold)
                    .foreground(DodamColor.Label.normal)
                Text("\(point.teacher.position) • \(point.issueAt)")
                    .label(.medium)
                    .foreground(DodamColor.Label.assistive)
            }
            .padding(.leading, 8)
            Spacer()
            Text("\(point.reason.score)")
                .headline(.bold)
                .foreground(
                    point.reason.scoreType == .minus
                    ? DodamColor.Status.negative
                    : DodamColor.Primary.normal
                )
                .padding(.trailing, 8)
        }
        .padding(.vertical, 8)
    }
}
