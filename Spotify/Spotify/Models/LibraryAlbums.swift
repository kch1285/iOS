//
//  LibraryAlbums.swift
//  Spotify
//
//  Created by chihoooon on 2021/09/10.
//

import Foundation

struct LibraryAlbums: Codable {
    let items: [SavedAlbum]
}

struct SavedAlbum: Codable {
    let album: Album
    let added_at: String
}
