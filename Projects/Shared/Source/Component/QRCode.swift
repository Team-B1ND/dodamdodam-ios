//
//  QRCode.swift
//  Shared
//
//  Created by hhhello0507 on 3/11/25.
//

import Foundation
import UIKit
import SwiftUI
import CoreImage.CIFilterBuiltins

public struct QRCodeView: View {
    private let data: Data
    
    public init(data: Data) {
        self.data = data
    }
    
    @ViewBuilder
    public static func from(string: String) -> some View {
        if let data = string.data(using: .utf8) {
            QRCodeView(data: data)
        } else {
            EmptyView()
        }
    }
    
    public var body: some View {
        Image(uiImage: generateQRCode(data: data))
            .resizable()
    }
    
    private func generateQRCode(data: Data) -> UIImage {
        let context = CIContext()
        let filter = CIFilter.qrCodeGenerator()

        filter.setValue(data, forKey: "inputMessage")

        if let qrCodeImage = filter.outputImage {
            let transform = CGAffineTransform(scaleX: 5, y: 5)
            let scaledCIImage = qrCodeImage.transformed(by: transform)
            if let qrCodeCGImage = context.createCGImage(scaledCIImage, from: scaledCIImage.extent) {
                return UIImage(cgImage: qrCodeCGImage)
            }
        }
        
        return UIImage()
    }
}
