//
//  AllItems.swift
//  FirstApp
//
//  Created by Zizo Adel on 12/21/19.
//  Copyright © 2019 Zizo Adel. All rights reserved.
//

import Foundation

// MARK: - AllItems
struct AllItems: Codable {
    let message: Bool?
    let data: [ItemData]?
}

// MARK: - Item data
struct ItemData: Codable {
    let id, userID: Int?
    let username, city, userToken, lat: String?
    let lng, title, itemDesc: String?
    let price: Int?
    let duration, favorited: String?
    let suspensed: Int?
    let humantime: String?
    let rate: Double?
    let createdAt: String?
    let images: [Image]?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case username, city
        case userToken = "user_token"
        case lat, lng, title
        case itemDesc = "item_desc"
        case price, duration, favorited, suspensed, humantime, rate
        case createdAt = "created_at"
        case images
    }
}

// MARK: - Image
struct Image: Codable {
    let id, itemID: Int?
    let image: String?

    enum CodingKeys: String, CodingKey {
        case id
        case itemID = "item_id"
        case image
    }
}
