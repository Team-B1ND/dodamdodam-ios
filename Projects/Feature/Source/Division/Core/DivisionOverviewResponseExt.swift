//
//  DivisionOverviewResponseExt.swift
//  Feature
//
//  Created by hhhello0507 on 2/4/25.
//

import Domain
import Shared

extension DivisionOverviewResponse: @retroactive Searchable {
    public var searchText: String {
        self.name
    }
}
