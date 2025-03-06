//
//  ViewKeyboardExt.swift
//  Shared
//
//  Created by hhhello0507 on 2/6/25.
//

import SwiftUI

public extension View {
    func hideKeyboardWhenTap() -> some View {
        self.onTapGesture(perform: hideKeyboard)
    }
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension UIApplication: UIKit.UIGestureRecognizerDelegate {
    public func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer,
        shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer
    ) -> Bool {
        return false
    }
}
