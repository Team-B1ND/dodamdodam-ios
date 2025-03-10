//
//  NoticeFile.swift
//  Feature
//
//  Created by hhhello0507 on 3/8/25.
//

import Foundation
import SwiftUI
import Domain
import DDS

struct NoticeFile: View {
    @EnvironmentObject private var dialog: DialogProvider
    
    let noticeFile: NoticeFileResponse
    
    var body: some View {
        HStack(spacing: 4) {
            Text(noticeFile.fileName)
                .label(.medium)
                .foreground(DodamColor.Label.neutral)
                .frame(maxWidth: .infinity, alignment: .leading)
            // TODO: Refactor
            Button {
                guard let url = noticeFile.fileUrl else { return }
                Task {
                    do {
                        let (tempUrl, response) = try await URLSession.shared.download(from: url)

                        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                            print(response)
                            return
                        }

                        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                        let downloadsFolder = documentDirectory.appendingPathComponent("Downloads")

                        if !FileManager.default.fileExists(atPath: downloadsFolder.path) {
                            try FileManager.default.createDirectory(at: downloadsFolder, withIntermediateDirectories: true, attributes: nil)
                        }
                        let destinationUrl = fileNameWithSuffix(in: downloadsFolder, fileName: noticeFile.fileName)

                        try FileManager.default.moveItem(at: tempUrl, to: destinationUrl)

                        dialog.present(
                            .init(title: "파일 다운로드 성공")
                        )
                    } catch {
                        print(error)
                        dialog.present(
                            .init(title: "파일 다운로드 실패")
                            .message("이미 다운로드 했거나 올바르지 않은 파일입니다.")
                        )
                    }
                }
                
                func fileNameWithSuffix(in folder: URL, fileName: String) -> URL {
                    let fileManager = FileManager.default
                    let fileExtension = (fileName as NSString).pathExtension // 확장자
                    let baseName = (fileName as NSString).deletingPathExtension // 확장자를 제외한 파일명
                    var fileURL = folder.appendingPathComponent(fileName)
                    var count = 1

                    while fileManager.fileExists(atPath: fileURL.path) {
                        let newFileName = "\(baseName) (\(count)).\(fileExtension)"
                        fileURL = folder.appendingPathComponent(newFileName)
                        count += 1
                    }

                    return fileURL
                }
            } label: {
                Image(icon: .file)
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 24, height: 24)
                    .padding(2)
                    .foreground(DodamColor.Static.white)
                    .background(DodamColor.Primary.normal)
                    .clipShape(Circle())
            }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 16)
        .frame(height: 60)
        .overlay {
            RoundedRectangle(cornerRadius: 8)
                .dodamStroke(DodamColor.Line.normal)
        }
    }
}
