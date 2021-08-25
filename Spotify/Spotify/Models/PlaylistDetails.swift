//
//  PlaylistDetails.swift
//  Spotify
//
//  Created by chihoooon on 2021/08/25.
//

import Foundation

struct PlaylistDetails: Codable{
    let description: String
    let external_urls: [String: String]
    let id: String
    let images: [APIImage]
    let name: String
    let tracks: PlaylistTrackResponse
}

struct PlaylistTrackResponse: Codable {
    let items: [PlaylistItem]
}

struct PlaylistItem: Codable {
    let track: AudioTrack
}
