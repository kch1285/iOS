//
//  AlbumDetails.swift
//  Spotify
//
//  Created by chihoooon on 2021/08/25.
//

import Foundation


struct AlbumDetails: Codable {
    let album_type: String
    let artists: [Artist]
    let available_markets: [String]
    let external_urls: [String: String]
    let id: String
    let images: [APIImage]
    let label: String
    let name: String
    let tracks: TrackResponse
    let popularity: Int
    let release_date: String
    let total_tracks: Int
}

struct TrackResponse: Codable {
    let items: [AudioTrack]
}
