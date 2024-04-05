//
//  DataSourceProtocol.swift
//  DodamDodam-MealWidget
//
//  Created by Mercen on 4/5/24.
//

protocol DataSourceProtocol {
    
    associatedtype Remote: RemoteProtocol
    
    var remote: Remote { get }
}
