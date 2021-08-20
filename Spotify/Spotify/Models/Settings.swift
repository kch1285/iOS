//
//  Settings.swift
//  Spotify
//
//  Created by chihoooon on 2021/08/20.
//

import Foundation

struct Section {
    let title: String?
    let options: [Option]
}

struct Option {
    let title: String
    let handler: () -> Void
}
