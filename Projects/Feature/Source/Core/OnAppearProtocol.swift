//
//  OnAppearProtocol.swift
//  Feature
//
//  Created by hhhello0507 on 9/28/24.
//

import Foundation

// AnyObject: Only viewmodel are allowed to confirm to the protocol
protocol OnAppearProtocol: AnyObject {
    // Set default to true.
    // Only viewmodel can be used.
    var isFirstOnAppear: Bool { get set }
    
    // Only viewmodel can be used.
    func fetchAllData() async
}

extension OnAppearProtocol {
    // Only view can be used.
    func onAppear() async {
        if isFirstOnAppear {
            await fetchAllData()
            self.isFirstOnAppear = false
        }
    }
}
