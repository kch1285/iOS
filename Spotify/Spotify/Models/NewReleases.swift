//
//  NewReleases.swift
//  Spotify
//
//  Created by chihoooon on 2021/08/20.
//

import Foundation

struct NewReleases: Codable {
    let albums: Albums
}

struct Albums: Codable {
    let items: [Album]
}

struct Album: Codable {
    let album_type: String
    let available_markets: [String]
    let id: String
    let images: [APIImage]
    let name: String
    let release_date: String
    let total_tracks: Int
    let artists: [Artist]
}
