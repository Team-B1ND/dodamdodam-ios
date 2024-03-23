//
//  OutApplyView.swift
//  DodamDodam
//
//  Created by 이민규 on 3/21/24.
//

import SwiftUI

struct OutApplyView: View {
    
    @InjectObject var viewModel: OutApplyViewModel
    @Flow var flow
    
    var body: some View {
        Text("OutApplyView")
    }
}

#Preview {
    OutApplyView()
}
