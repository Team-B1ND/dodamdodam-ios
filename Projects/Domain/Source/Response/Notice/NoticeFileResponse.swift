//
//  NoticeFileResponse.swift
//  Domain
//
//  Created by hhhello0507 on 3/8/25.
//

import Foundation

public struct NoticeFileResponse: ResponseProtocol {
    public let fileUrl: URL?
    public let fileName: String
    public let fileType: FileType
    
    public init(fileUrl: URL?, fileName: String, fileType: FileType) {
        self.fileUrl = fileUrl
        self.fileName = fileName
        self.fileType = fileType
    }
}

public extension [NoticeFileResponse] {
    func find(fileType: FileType) -> [NoticeFileResponse] {
        filter { $0.fileType == fileType }
    }
}
