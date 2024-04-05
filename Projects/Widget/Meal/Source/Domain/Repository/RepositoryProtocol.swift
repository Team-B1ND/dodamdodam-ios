//
//  RepositoryProtocol.swift
//  DodamDodam-MealWidget
//
//  Created by Mercen on 4/5/24.
//

protocol RepositoryProtocol {
    
    associatedtype DataSource: DataSourceProtocol
    
    var dataSource: DataSource { get }
}
