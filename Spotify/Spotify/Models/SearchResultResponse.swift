//
//  SearchResultResponse.swift
//  Spotify
//
//  Created by chihoooon on 2021/08/29.
//

import Foundation

struct SearchResultResponse: Codable {
    let albums: SearchAlbumResults
    let artists: SearchArtistResults
    let playlists: SearchPlaylistResults
    let tracks: SearchTrackResults
}

struct SearchAlbumResults: Codable {
    let items: [Album]
}

struct SearchArtistResults: Codable {
    let items: [Artist]
}

struct SearchPlaylistResults: Codable {
    let items: [Playlist]
}

struct SearchTrackResults: Codable {
    let items: [AudioTrack]
}
