//
//  Playlist.swift
//  Spotify
//
//  Created by chihoooon on 2021/08/14.
//

import Foundation

struct Playlist: Codable {
    let description: String
    let external_urls: [String: String]
    let id: String
    let images: [APIImage]
    let name: String
    let snapshot_id: String
    let owner: Owner
}

struct Owner: Codable {
    let display_name: String
    let external_urls: [String: String]
    let id: String
}
