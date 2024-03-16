//
//  NavigationController.swift
//  DodamDodam
//
//  Created by 이민규 on 3/14/24.
//

import SwiftUI

class NavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAppearance()
    }
    
    override open var childForStatusBarStyle: UIViewController? {
        return topViewController
    }
    
    private var backButtonImage: UIImage? {
        return UIImage(resource: .chevronLeft)
    }
    
    private var backButtonAppearance: UIBarButtonItemAppearance {
        let appearance = UIBarButtonItemAppearance()
        appearance.normal.titleTextAttributes[.foregroundColor] = UIColor.clear
        appearance.normal.titleTextAttributes[.font] = UIFont.systemFont(ofSize: 0)
        return appearance
    }
    
    private func setAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemBackground
        appearance.shadowColor = .clear
        appearance.setBackIndicatorImage(
            backButtonImage,
            transitionMaskImage: backButtonImage
        )
        appearance.backButtonAppearance = backButtonAppearance
        appearance.titleTextAttributes[.foregroundColor] = UIColor.clear
        navigationBar.standardAppearance = appearance
        navigationBar.isTranslucent = true
        navigationBar.tintColor = .label
    }
}
