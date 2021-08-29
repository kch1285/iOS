//
//  SearchResults.swift
//  Spotify
//
//  Created by chihoooon on 2021/08/29.
//

import Foundation

enum SearchResults {
    case artist(model: Artist)
    case album(model: Album)
    case playlist(model: Playlist)
    case track(model: AudioTrack)
}
