//
//  FavoritesListViewModel.swift
//  CoinCase
//
//  Created by Osman Murat Haslak on 10.10.2023.
//

import Foundation

protocol FavoritesListViewModelInterface {
    var view: FavoritesListScreenInterface? { get set }
    
    func viewDidLoad()
}

final class FavoritesListViewModel {
    weak var view: FavoritesListScreenInterface?
    

}

extension FavoritesListViewModel: FavoritesListViewModelInterface {
    
    func viewDidLoad() {
        view?.configureVC()
        view?.configureMyTotalCoinBalance()
        view?.configureTableView()
    }
 
}
