import FlowKit
import SwiftUI
import DDS

public struct FlowPreview<C: View>: View {
    
    private let content: () -> C
    
    public init(@ViewBuilder content: @escaping () -> C) {
        self.content = content
    }
    
    public var body: some View {
        FlowKit.FlowPresenter(rootView: content())
            .ignoresSafeArea()
    }
}
