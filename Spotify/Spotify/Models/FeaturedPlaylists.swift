//
//  FeaturedPlaylists.swift
//  Spotify
//
//  Created by chihoooon on 2021/08/20.
//

import Foundation

struct FeaturedPlaylists: Codable {
    let playlists: PlaylistResponse
}

struct PlaylistResponse: Codable {
    let items: [Playlist]
}
