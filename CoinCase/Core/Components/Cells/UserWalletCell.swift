//
//  UserWalletCell.swift
//  CoinCase
//
//  Created by Osman Murat Haslak on 11.10.2023.
//

import UIKit

class UserWalletCell: UITableViewCell {
    
    static let reuseID = "UserWalletCell"
    
    let customImageView = IconImageView(frame: .zero, imageName: "bitcoin")
    
    let coinName = CCTitleLabel(textAlignment: .left, fontSize: 16)
    let priceLabel = CCTitleLabel(textAlignment: .left, fontSize: 16)
    let coinSub = CCBodyLabel(textAlignment: .left, fontSize: 10)
    let countLabel = CCTitleLabel(textAlignment: .right, fontSize: 16)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        layer.cornerRadius = 30
        clipsToBounds = true
        
        addSubview(customImageView)
        addSubview(coinName)
        addSubview(coinSub)
        addSubview(priceLabel)
        addSubview(countLabel)
        
        NSLayoutConstraint.activate([
            customImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            customImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            customImageView.widthAnchor.constraint(equalToConstant: 40),
            customImageView.heightAnchor.constraint(equalToConstant: 40),
            
            coinName.leadingAnchor.constraint(equalTo: customImageView.trailingAnchor, constant: 16),
            coinName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            coinName.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            
            coinSub.leadingAnchor.constraint(equalTo: coinName.leadingAnchor),
            coinSub.trailingAnchor.constraint(equalTo: coinName.trailingAnchor),
            coinSub.topAnchor.constraint(equalTo: coinName.bottomAnchor, constant: 4),
            coinSub.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            
            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            priceLabel.topAnchor.constraint(equalTo: coinName.topAnchor),
            
            countLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            countLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor),
            countLabel.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -10),

            
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(coin: CoinsResult) {
        coinName.text = coin.symbol
        coinSub.text = "Bitcoin"
        priceLabel.text = String(coin.coinCount!)
        
        if let coinCountDouble = coin.coinCount, let lowPriceString = coin.lowPrice, let lowPriceDouble = Double(lowPriceString) {
            let totalPrice = coinCountDouble * lowPriceDouble
            let formattedPrice = String(format: "%.5f", totalPrice)
            countLabel.text = Utils.formatCurrency(price: formattedPrice)
        } else {
            countLabel.text = "0" // Herhangi bir dönüşüm hatası veya nil değeri durumunda varsayılan değer
        }
    }
}

