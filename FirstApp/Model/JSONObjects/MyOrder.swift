//
//  MyOrder.swift
//  FirstApp
//
//  Created by Zizo Adel on 1/18/20.
//  Copyright © 2020 Zizo Adel. All rights reserved.
//

import Foundation

// MARK: - AllTeacher
struct MyOrder: Codable {
    let message: Bool?
    let data: [MyOrderData]?
}

// MARK: - Datum
struct MyOrderData: Codable {
    let id, itemID: Int?
    let itemname, username: String?
    let familyID: Int?
    let familyName, lat, lng: String?
    let qty, price, status: Int?
    let date: String?
    let itemimgs: [MyOrderImage]?

    enum CodingKeys: String, CodingKey {
        case id
        case itemID = "item_id"
        case itemname, username
        case familyID = "family_id"
        case familyName = "family_name"
        case lat, lng, qty, price, status, date, itemimgs
    }
}

struct MyOrderImage: Codable {
    let id, itemID: Int?
    let image: String?

    enum CodingKeys: String, CodingKey {
        case id
        case itemID = "item_id"
        case image
    }
}
