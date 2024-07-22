//
//  AppUtil.swift
//  DodamDodam
//
//  Created by 이민규 on 4/5/24.
//

import Foundation

func getAppVersion() -> String {

    guard let infoDictionary = Bundle.main.infoDictionary else {
        return "error"
    }
    guard let version = infoDictionary["CFBundleShortVersionString"] as? String else {
        return  "error"
    }
    return version
}
