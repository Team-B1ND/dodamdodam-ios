//
//  Inject.swift
//  DodamDodam-MealWidget
//
//  Created by Mercen on 4/5/24.
//

import Swinject

@propertyWrapper
public struct Inject<T> {
    
    public let wrappedValue: T = {
        if let value = DependencyProvider.shared.container.resolve(T.self) {
            return value
        } else {
            fatalError("Injection error: \(T.self)")
        }
    }()
    
    public init() { }
}
