//
//  RepositoryProtocol.swift
//  DodamDodam
//
//  Created by Mercen on 3/28/24.
//

protocol RepositoryProtocol {
    
    associatedtype DataSource: DataSourceProtocol
    
    var dataSource: DataSource { get }
}
