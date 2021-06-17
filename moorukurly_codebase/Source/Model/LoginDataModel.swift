//
//  LoginDataModel.swift
//  moorukurly_codebase
//
//  Created by 윤예지 on 2021/06/17.
//

import Foundation

struct LoginDataModel: Codable {
    let token: String
    
    enum CodingKeys: String, CodingKey {
        case token
    }
    
    init(from decoder : Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        token = (try? values.decode(String.self, forKey: .token)) ?? ""
    }
}
