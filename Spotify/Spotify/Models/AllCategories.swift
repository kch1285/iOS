//
//  AllCategories.swift
//  Spotify
//
//  Created by chihoooon on 2021/08/26.
//

import Foundation

struct AllCategories: Codable {
    let categories: Categories
}

struct Categories: Codable {
    let items: [CategoryItem]
    let total: Int
}

struct CategoryItem: Codable {
    let id: String
    let name: String
    let icons: [APIImage]
}
