//
//  PointCell.swift
//  DodamDodam
//
//  Created by hhhello0507 on 7/20/24.
//

import SwiftUI

public struct PointCell: View {
    
    private let point: PointResponse
    
    public init(point: PointResponse) {
        self.point = point
    }
    
    public var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 0) {
                Text("\(point.reason.reason)")
                    .font(.body(.large))
                    .dodamColor(.onBackground)
                Text("\(point.teacher.position) • \(point.issueAt)")
                    .font(.label(.large))
                    .dodamColor(.onSurfaceVariant)
            }
            .padding(.leading, 8)
            Spacer()
            Text("\(point.reason.score)")
                .font(.body(.large))
                .dodamColor(point.reason.scoreType == .minus
                            ? .error
                            : .primary
                )
                .padding(.trailing, 8)
        }
        .padding(.vertical, 8)
    }
}
