//
//  CoinData.swift
//  HowMuchIsOneBit
//
//  Created by chihoooon on 2021/11/24.
//

import Foundation

struct CoinData: Decodable {
    let rate: Double
    let asset_id_quote: String
}
