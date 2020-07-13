//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = ""
    
    var delegate: CoinManagerDelegate? = nil
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    
    func getCoinPrice(for currency: String) {
        let urlString = baseURL + "/" + currency + "?apikey=" + apiKey
        
        if let url = URL(string: urlString) {
            let urlSession = URLSession(configuration: .default)
            let dataTask = urlSession.dataTask(with: url) { (data, urlResponse, error) in
                            
                if let data = data {
                    let jsonDecoder = JSONDecoder()
                    do {
                        let response = try jsonDecoder.decode(CoinResponse.self, from: data)
                        let rate = response.rate
                        DispatchQueue.main.async {
                            self.delegate?.coinManager(self, successGet: rate)
                        }
                    } catch {
                        print("error: \(error)")
                    }
                }
                
            }
            dataTask.resume()
        }
    }

    
}
