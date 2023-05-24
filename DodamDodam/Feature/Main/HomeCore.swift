//
//  HomeCore.swift
//  DodamDodam
//
//  Created by 이민규 on 2023/05/24.
//  Copyright © 2023 B1ND. All rights reserved.
//

import ComposableArchitecture
import Combine

public struct Home: ReducerProtocol {
    
    public struct State: Equatable {
        
    }
    
    public enum Action: Equatable {
        
        case onTapButton
    }
    
    public var body: some ReducerProtocol<State, Action> {
        
        Reduce { state, action in
            
            switch action {
                
            case .onTapButton:
                print("도담도담")
                return .none
            }
        }
    }
}

