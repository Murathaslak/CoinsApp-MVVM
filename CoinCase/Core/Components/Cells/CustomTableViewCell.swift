//
//  CustomTableViewCell.swift
//  CoinCase
//
//  Created by Osman Murat Haslak on 7.10.2023.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    static let reuseID = "CoinCell"
    let priceChangePercentBackgroundView = UIView()

    let customImageView = IconImageView(frame: .zero, imageName: "bitcoin")
    let coinName = CCTitleLabel(textAlignment: .left, fontSize: 16)
    let coinSub = CCBodyLabel(textAlignment: .left, fontSize: 10)
    let lastPriceLabel = CCTitleLabel(textAlignment: .right, fontSize: 16)
    let priceChangePercentLabel = CCBodyLabel(textAlignment: .left, fontSize: 10)

    override func prepareForReuse() {
        priceChangePercentBackgroundView.backgroundColor = UIColor.clear
    }
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        layer.cornerRadius = 30
        clipsToBounds = true
                
        addSubview(coinName)
        addSubview(coinSub)
        addSubview(customImageView)
        addSubview(lastPriceLabel)
        addSubview(priceChangePercentLabel)
        addSubview(priceChangePercentBackgroundView)
        
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
            
            lastPriceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            lastPriceLabel.topAnchor.constraint(equalTo: coinName.topAnchor),
            
            priceChangePercentLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            priceChangePercentLabel.topAnchor.constraint(equalTo: lastPriceLabel.bottomAnchor),
                        
        ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure(coin: CoinsResult) {
        coinName.text = coin.symbol
        let coinSymbol = coin.symbol
        if coinSymbol!.count >= 3 {
            let truncatedSymbol = String(coinSymbol!.dropLast(3))
            coinSub.text = truncatedSymbol
        } else {
            coinSub.text = coinSymbol
        }
        lastPriceLabel.text = coin.lastPrice! + " ₺"
        
        
        if let priceChangePercentValue = Double(coin.priceChangePercent!) {
            if priceChangePercentValue < 0.0 {
                priceChangePercentBackgroundView.backgroundColor = UIColor.red.withAlphaComponent(0.5)
                lastPriceLabel.textColor = UIColor.systemRed
                lastPriceLabel.text = "▼ " + (coin.lastPrice! )
                
            } else if priceChangePercentValue > 0.0 {
                priceChangePercentBackgroundView.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.5)
                lastPriceLabel.textColor = UIColor.systemGreen
                lastPriceLabel.text = "▲ " + (coin.lastPrice! )
            } else {
                priceChangePercentBackgroundView.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
                lastPriceLabel.textColor = UIColor.gray
            }
        }
        
        priceChangePercentLabel.text = coin.priceChangePercent
        priceChangePercentLabel.textColor = UIColor.black
        priceChangePercentLabel.font = .systemFont(ofSize: 14, weight: .bold)
        
        priceChangePercentBackgroundView.layer.cornerRadius = 5
        priceChangePercentBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            priceChangePercentBackgroundView.trailingAnchor.constraint(equalTo: priceChangePercentLabel.trailingAnchor, constant: 4),
            priceChangePercentBackgroundView.topAnchor.constraint(equalTo: priceChangePercentLabel.topAnchor, constant: -2),
            priceChangePercentBackgroundView.bottomAnchor.constraint(equalTo: priceChangePercentLabel.bottomAnchor, constant: 2),
            priceChangePercentBackgroundView.leadingAnchor.constraint(equalTo: priceChangePercentLabel.leadingAnchor, constant: -4)
        ])
    }


}
