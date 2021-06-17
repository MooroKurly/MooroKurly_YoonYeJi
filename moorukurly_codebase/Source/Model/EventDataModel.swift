//
//  EventDataModel.swift
//  moorukurly_codebase
//
//  Created by 윤예지 on 2021/06/18.
//

import Foundation

struct EventDataModel : Codable {
    let id: String
    let thumbnail: String
    let title, subtitle, keyword: String
    let v: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case thumbnail, title, subtitle, keyword
        case v = "__v"
    }
}
