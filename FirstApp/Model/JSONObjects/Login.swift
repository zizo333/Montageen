//
//  Login.swift
//  FirstApp
//
//  Created by Zizo Adel on 12/21/19.
//  Copyright © 2019 Zizo Adel. All rights reserved.
//

import Foundation

// MARK: - Login
struct Login: Codable {
    let message: Bool?
    let data: UserData?
}

// MARK: - DataClass
struct UserData: Codable {
    let id: Int?
    let name, email, phone, image: String?
    let city, role: Int?
    let password, lat, lng, firebaseToken: String?
    let deviceID: String?
    let suspensed: Int?
    let userHash, cityname: String?

    enum CodingKeys: String, CodingKey {
        case id, name, email, phone, image, city, role, password, lat, lng
        case firebaseToken = "firebase_token"
        case deviceID = "device_id"
        case suspensed
        case userHash = "user_hash"
        case cityname
    }
}
