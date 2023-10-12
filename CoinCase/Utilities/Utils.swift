//
//  Utils.swift
//  CoinCase
//
//  Created by Osman Murat Haslak on 9.10.2023.
//

import Foundation

class Utils {
    static func formatCurrency(price: String) -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.currencySymbol = "₺"
        
        if let priceDouble = Double(price), let formattedPrice = numberFormatter.string(from: NSNumber(value: priceDouble)) {
            return "\(formattedPrice)"
        }
        
        return nil
    }
    
    static func formatCurrencyDouble(price: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.currencySymbol = "₺"
        
        if let formattedPrice = numberFormatter.string(from: NSNumber(value: price)) {
            return "\(formattedPrice)"
        }
        
        return ""
    }

}
