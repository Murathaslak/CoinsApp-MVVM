//
//  MyCoinsListViewModel.swift
//  CoinCase
//
//  Created by Osman Murat Haslak on 10.10.2023.
//

import Foundation

protocol MyCoinsListViewModelInterface {
    var view: MyCoinsListScreenInterface? { get set }
    
    func viewDidLoad()
}

final class MyCoinsListViewModel {
    weak var view: MyCoinsListScreenInterface?
    

}

extension MyCoinsListViewModel: MyCoinsListViewModelInterface {
    
    func viewDidLoad() {
        view?.configureVC()
        view?.configureMyTotalCoinBalance()
        view?.configureTableView()
    }
 
}
