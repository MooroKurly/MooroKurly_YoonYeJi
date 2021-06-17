//
//  APIConstants.swift
//  moorukurly_codebase
//
//  Created by 윤예지 on 2021/06/17.
//

import Foundation

struct APIConstants {
    
    static let baseURL = "http://13.125.239.17:5000/api"
    
    static let loginURL = baseURL + "/auth"
    static let signupURL = baseURL + "/user"
    
    static let adURL = baseURL + "/products/ad"
    static let thisURL = baseURL + "/products/this"
    static let bigSaleURL = baseURL + "/products/bigsale"
    static let eventURL = baseURL + "/products/event"
    static let onedayURL = baseURL + "/products/oneday"
}
