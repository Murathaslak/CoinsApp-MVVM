//
//  HomeViewModel.swift
//  CoinCase
//
//  Created by Osman Murat Haslak on 7.10.2023.
//

import Foundation

protocol HomeViewModelInterface {
    var view: HomeScreenInterface? { get set }
    
    func viewDidLoad()
    func getCoins()
}


final class HomeViewModel {
    weak var view: HomeScreenInterface?
    private let service = CoinService()
    var coins: [CoinsResult] = []
}

extension HomeViewModel: HomeViewModelInterface {
    
    func viewDidLoad() {
        view?.configureVC()
        view?.configureNavigationBar()
//        view?.configureAppBar()
        view?.configureTableView()
        getCoins()
        view?.configureBuySellButtonsCell()
        view?.configureTextFields()
        view?.configureTotalBalanceCell()
        view?.configureSubmitButton()
    }
    
    func getCoins() {
        service.downloadCoins { [weak self] returnedCoins in
            guard let self = self else { return }
            guard let returnedCoins = returnedCoins else { return }
        
            let tryCoins = returnedCoins.compactMap { coin -> CoinsResult? in
                if coin.symbol!.hasSuffix("TRY") {
                    var newCoin = coin
                    if let formattedPrice = Utils.formatCurrency(price: coin.lastPrice!) {
                        newCoin.lastPrice = formattedPrice
                        newCoin.coinCount = 0
                        return newCoin
                    }
                }
                return nil
            }
            self.coins = tryCoins
            view?.reloadTableViewData()
        }
    }
}

