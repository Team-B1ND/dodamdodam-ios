//
//  DataSourceProtocol.swift
//  DodamDodam
//
//  Created by Mercen on 3/28/24.
//

import Foundation
import Moya

protocol DataSourceProtocol {
    
    associatedtype Remote: RemoteProtocol
    
    var remote: Remote { get }
}
