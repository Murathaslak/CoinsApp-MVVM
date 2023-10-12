//
//  UserCoin.swift
//  CoinCase
//
//  Created by Osman Murat Haslak on 9.10.2023.
//

import Foundation

class UserCoin {
    var adet: String?
    var maliyet: String?
    var symbol: String?
    var odenenTutar: String?
    
    init(adet: String? = nil, maliyet: String? = nil, symbol: String? = nil, odenenTutar: String? = nil) {
        self.adet = adet
        self.maliyet = maliyet
        self.symbol = symbol
        self.odenenTutar = odenenTutar
    }
}

struct MockData {
    static let fakeCoins = [
        UserCoin(adet: "20",maliyet: "20",symbol: "BTC",odenenTutar: "400"),
        UserCoin(adet: "20",maliyet: "20",symbol: "BTC",odenenTutar: "400"),
        UserCoin(adet: "20",maliyet: "20",symbol: "BTC",odenenTutar: "400"),
        UserCoin(adet: "20",maliyet: "20",symbol: "BTC",odenenTutar: "400"),
        UserCoin(adet: "20",maliyet: "20",symbol: "BTC",odenenTutar: "400"),
        UserCoin(adet: "20",maliyet: "20",symbol: "BTC",odenenTutar: "400"),
        UserCoin(adet: "20",maliyet: "20",symbol: "BTC",odenenTutar: "400"),
        UserCoin(adet: "20",maliyet: "20",symbol: "BTC",odenenTutar: "400"),
        UserCoin(adet: "20",maliyet: "20",symbol: "BTC",odenenTutar: "400"),

    ]
}

