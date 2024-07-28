import FlowKit
import SwiftUI

//@available(iOS 13, *)
//@propertyWrapper
//public struct Flow: DynamicProperty {
//  
//  @EnvironmentObject private var object: FlowProvider
//  
//  public var wrappedValue: FlowProvider {
//    object
//  }
//  
//  public init() { }
//}

public struct FlowPreview<C: View>: View {
    
    private let content: () -> C
    
    public init(@ViewBuilder content: @escaping () -> C) {
        self.content = content
    }
    
    public var body: some View {
        FlowPresenter(rootView: content())
            .ignoresSafeArea()
    }
}
