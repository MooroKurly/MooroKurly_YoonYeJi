//
//  ProductDataModel.swift
//  moorukurly_codebase
//
//  Created by 윤예지 on 2021/05/28.
//

import Foundation

struct ProductModelData: Codable {
    let id: String
    let thumbnail: String
    let store, title, subtitle: String
    let price: Int?
    let discount: Int?
    let category: String
    let bargain: Int?
    let v: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case thumbnail, store, title, subtitle, price, discount, category, bargain
        case v = "__v"
    }

    init(from decoder : Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = (try? values.decode(String.self, forKey: .id)) ?? ""
        thumbnail = (try? values.decode(String.self, forKey: .thumbnail)) ?? ""
        store = (try? values.decode(String.self, forKey: .store)) ?? ""
        title = (try? values.decode(String.self, forKey: .title)) ?? ""
        subtitle = (try? values.decode(String.self, forKey: .subtitle)) ?? ""
        price = (try? values.decode(Int.self, forKey: .price)) ?? nil
        discount = (try? values.decode(Int.self, forKey: .discount)) ?? 0
        bargain = (try? values.decode(Int.self, forKey: .bargain)) ?? nil
        category = (try? values.decode(String.self, forKey: .category)) ?? ""
        v = (try? values.decode(Int.self, forKey: .v)) ?? 0
    }
}
