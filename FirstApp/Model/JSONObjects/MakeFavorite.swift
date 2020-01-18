//
//  MakeFavorite.swift
//  FirstApp
//
//  Created by Zizo Adel on 1/5/20.
//  Copyright © 2020 Zizo Adel. All rights reserved.
//

import Foundation
struct MakeFavorite: Codable {
    let message: Bool?
    let data: String?
}

enum FavoriteState {
    case delete
    case add
}
