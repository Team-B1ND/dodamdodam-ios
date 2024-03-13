//
//  InjectObject.swift
//  DodamDodam
//
//  Created by Mercen on 3/13/24.
//

import SwiftUI
import Swinject

@propertyWrapper
public struct InjectObject<T>: DynamicProperty where T: ObservableObject {
    
    @StateObject private var object: T = {
        if let value = DependencyProvider.shared.container.resolve(T.self) {
            return value
        } else {
            fatalError("Injection error: \(T.self)")
        }
    }()
    
    public var wrappedValue: T {
        object
    }
    
    public var projectedValue: ObservedObject<T>.Wrapper {
        $object
    }
    
    public init() { }
}
