//
//  Cart.swift
//  FirstApp
//
//  Created by Zizo Adel on 1/7/20.
//  Copyright © 2020 Zizo Adel. All rights reserved.
//

import Foundation

struct Cart: Codable {
    let message: Bool?
    let data: String?
}

// MARK: - CartItems
struct CartItems: Codable {
    let message: Bool?
    let data: [CartData]?
}

// MARK: - Datum
struct CartData: Codable {
    let id, itemID: Int?
    let itemTitle, itemDesc, city: String?
    let owner, trader: Int?
    let tradername, lat, lng: String?
    let qty: Int?
    let favorited: String?
    let price: Int?
    let duration: String?
    let status: Int?
    let humantime, createdAt: String?
    let images: [CartImage]?

    enum CodingKeys: String, CodingKey {
        case id
        case itemID = "item_id"
        case itemTitle = "item_title"
        case itemDesc = "item_desc"
        case city, owner, trader, tradername, lat, lng, qty, favorited, price, duration, status, humantime
        case createdAt = "created_at"
        case images
    }
}

// MARK: - Image
struct CartImage: Codable {
    let id, itemID: Int?
    let image: String?

    enum CodingKeys: String, CodingKey {
        case id
        case itemID = "item_id"
        case image
    }
}

// MARK: - Delete item from the cart
struct DeleteCartItem: Codable {
    let message: Bool?
    let data: String?
}
