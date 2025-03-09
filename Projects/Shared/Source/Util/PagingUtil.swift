//
//  PagingUtil.swift
//  Shared
//
//  Created by hhhello0507 on 2/14/25.
//

import Foundation

public enum PagingUtil {
    public static func isLastPage(index: Int, pagingInterval: Int, count: Int) -> Bool {
        return index % pagingInterval == (pagingInterval - 1) &&
               index / pagingInterval == (count - 1) / pagingInterval
    }
}
