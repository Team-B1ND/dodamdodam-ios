//
//  Response.swift
//  DodamDodam-MealWidget
//
//  Created by Mercen on 4/5/24.
//

struct Response<T: ResponseProtocol>: ResponseProtocol {
    
    var status: Int
    var message: String
    var data: T
}
