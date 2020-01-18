//
//  Order.swift
//  FirstApp
//
//  Created by Zizo Adel on 1/7/20.
//  Copyright © 2020 Zizo Adel. All rights reserved.
//

import Foundation

// MARK: - Order
struct Order: Codable {
    let message: Bool?
    let data: [Data]?
}

// MARK: - Datum
struct Data: Codable {
    let id, itemID: Int?
    let itemname, username: String?
    let familyID: Int?
    let familyName, lat, lng: String?
    let qty, price, status: Int?
    let date: String?
    let itemimgs: [Itemimg]?

    enum CodingKeys: String, CodingKey {
        case id
        case itemID = "item_id"
        case itemname, username
        case familyID = "family_id"
        case familyName = "family_name"
        case lat, lng, qty, price, status, date, itemimgs
    }
}

// MARK: - Itemimg
struct Itemimg: Codable {
    let id, itemID: Int?
    let image: String?

    enum CodingKeys: String, CodingKey {
        case id
        case itemID = "item_id"
        case image
    }
}
