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
        interactivePopGestureRecognizer?.isEnabled = false
        let popGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        popGestureRecognizer.delegate = self
        view.addGestureRecognizer(popGestureRecognizer)
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        viewControllers.count > 1
    }
    
    @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        if let interactivePopGesture = interactivePopGestureRecognizer,
           let targets = interactivePopGesture.value(forKey: "targets") as? [NSObject],
           let targetObject = targets.first,
           let target = targetObject.value(forKey: "target") as? AnyObject {
            let selector = NSSelectorFromString("handleNavigationTransition:")
            _ = target.perform(selector, with: gesture)
        }
    }
}
