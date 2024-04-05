//
//  SettingView.swift
//  DodamDodam
//
//  Created by 이민규 on 4/5/24.
//

import SwiftUI
import DDS

struct SettingView: View {
    
//    let myData: MemberResponse
    @Flow var flow
    
    var body: some View {
        DodamScrollView.medium(title: "설정") {
            
        }
    }
}

#Preview {
    FlowPreview {
        SettingView()
    }
}
