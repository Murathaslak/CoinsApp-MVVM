//
//  CCError.swift
//  CoinCase
//
//  Created by Osman Murat Haslak on 9.10.2023.
//

import Foundation

enum CCError: String {
    case yetersizBakiye = "Bakiyeniz yetersiz."
    case yetersizTutar = "Hesabınızda yeterli tutar bulunmamaktadır."
    case basariliSatinAlma = "Satın alma işlemi başarılı."
    case hataliCoinMiktarTutar = "Hatalı coin miktarı veya fiyat"
    case yetersizCoin = "Yeterli miktarda coin bulunmamaktadır."
    case basariliCoinSatis = "Satış başarılı, tutar hesabınıza yansımıştır."
    case uyari = "Lütfen bir kripto para birimi seçtiğinizden emin olun veya bir geçerli tutar girin."
    case gerekliAlan = "Lütfen gerekli alanları doldurunuz."
    case gecerliMiktar = "Lütfen geçerli bir maaliyet giriniz."
}
