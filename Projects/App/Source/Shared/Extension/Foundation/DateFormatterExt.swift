//
//  DateFormatterExt.swift
//  DodamDodam
//
//  Created by hhhello0507 on 7/20/24.
//

import Foundation

public extension DateFormatter {
    convenience init(_ dateFormat: String, locale: Locale = Locale(identifier: "ko_KR")) {
        self.init()
        self.dateFormat = dateFormat
        self.locale = locale
    }
}
