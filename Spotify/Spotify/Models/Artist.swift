//
//  Artist.swift
//  Spotify
//
//  Created by chihoooon on 2021/08/14.
//

import Foundation

struct Artist: Codable {
    let id: String
    let name: String
    let type: String
    let external_urls: [String: String]
}
