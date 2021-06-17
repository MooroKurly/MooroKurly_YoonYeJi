//
//  NerworkResult.swift
//  moorukurly_codebase
//
//  Created by 윤예지 on 2021/06/17.
//

import Foundation

enum NetworkResult<T> {
    case success(T)
    case requestErr(T)
    case pathErr
    case serverErr
    case networkFail
}
