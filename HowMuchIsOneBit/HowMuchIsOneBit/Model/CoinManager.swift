//
//  CoinManager.swift
//  HowMuchIsOneBit
//
//  Created by chihoooon on 2021/11/24.
//

import Foundation

protocol CoinManagerDelegate: AnyObject {
    func didUpdatePrice(_ coin: CoinModel)
}

struct CoinManager {
    var delegate: CoinManagerDelegate?
    
    private let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    private let apiKey = "492CDC3B-67DE-47F6-A79F-5E2851A640FE"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func getCoinPrice(for unit: String) {
        let urlString = "\(baseURL)/\(unit)?apikey=\(apiKey)"
        performRequest(with: urlString)
    }

    func performRequest(with urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            guard let price = parseJSON(data) else {
                return
            }
            delegate?.didUpdatePrice(price)
        }
        
        task.resume()
    }
    
    func parseJSON(_ data: Data) -> CoinModel? {
        let decoder = JSONDecoder()
        
        do {
            let decodeData = try decoder.decode(CoinData.self, from: data)
            let coin = CoinModel(rate: decodeData.rate, currency: decodeData.asset_id_quote)
            return coin
        }
        catch {
            return nil
        }
    }
}
