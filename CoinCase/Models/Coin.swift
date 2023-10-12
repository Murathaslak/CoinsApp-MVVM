//
//  Coin.swift
//  CoinCase
//
//  Created by Osman Murat Haslak on 7.10.2023.
//

import Foundation

struct CoinsResult: Codable {
    var symbol: String?
    var priceChangePercent: String?
    var lastPrice: String?
    var highPrice: String?
    var lowPrice: String?
    var coinCount: Double?
}
