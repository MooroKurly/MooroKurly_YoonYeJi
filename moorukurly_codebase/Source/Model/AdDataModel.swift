//
//  AdDataModel.swift
//  moorukurly_codebase
//
//  Created by 윤예지 on 2021/06/18.
//

import Foundation

struct AdDataModel: Codable {
    let _id: String
    let img: String
    
    enum CodingKeys: String, CodingKey {
        case _id
        case img
    }
    
    init(from decoder : Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _id = (try? values.decode(String.self, forKey: ._id)) ?? ""
        img = (try? values.decode(String.self, forKey: .img)) ?? ""
    }
    
}
