//
//  UINavigationControllerExt.swift
//  DodamDodam
//
//  Created by hhhello0507 on 7/28/24.
//

import UIKit

extension UINavigationController: UIKit.UIGestureRecognizerDelegate {
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.isHidden = true
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        viewControllers.count > 1
    }
}
