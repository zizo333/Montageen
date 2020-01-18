//
//  AllFamilies.swift
//  FirstApp
//
//  Created by Zizo Adel on 12/22/19.
//  Copyright © 2019 Zizo Adel. All rights reserved.
//

// MARK: - AllFamilies
struct AllFamilies: Codable {
    let message: Bool?
    let data: [FamilyData]?
}

// MARK: - Family data
struct FamilyData: Codable {
    let id: Int?
    let username, lat, lng: String?
    let suspensed: Int?
    let image, city: String?
    let itemcount: Int?
}
