//
//  Register.swift
//  FirstApp
//
//  Created by Zizo Adel on 12/20/19.
//  Copyright © 2019 Zizo Adel. All rights reserved.
//

// MARK: - Register
struct Register: Codable {
    let message: Bool?
    let data: UserInfo?
}

// MARK: - DataClass
struct UserInfo: Codable {
    let name, email, phone, city: String?
    let role: String?
    let suspensed: Int?
    let lat, lng, password, firebaseToken: String?
    let deviceID, userHash: String?
    let id: Int?
    let cityname: String?

    enum CodingKeys: String, CodingKey {
        case name, email, phone, city, role, suspensed, lat, lng, password
        case firebaseToken = "firebase_token"
        case deviceID = "device_id"
        case userHash = "user_hash"
        case id, cityname
    }
}

class NewUser {
    
    var name: String?
    var email: String?
    var password: String?
    var city: String?
    var phoneNumber: String?
    var userType: String?
    
}
