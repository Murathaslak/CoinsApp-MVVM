//
//  FavoritesListScreen.swift
//  CoinCase
//
//  Created by Osman Murat Haslak on 9.10.2023.
//

import UIKit

protocol FavoritesListScreenInterface: AnyObject {
    func configureVC()
    func configureMyTotalCoinBalance()
    func configureTableView()
}

class FavoritesListScreen: UIViewController {
  
    private let viewModel = FavoritesListViewModel()
    private var tableView = UITableView()
    
    var dataCount: [CoinsResult] = []
    
    var myBalance = CCBodyLabel(textAlignment: .left, fontSize: 16)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.view = self
        viewModel.viewDidLoad()
        

    }
}

extension FavoritesListScreen: FavoritesListScreenInterface {
    
    func configureVC() {
        view.backgroundColor = .systemGray5
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Cüzdanım"
        navigationController?.navigationBar.tintColor = .white
        navigationItem.largeTitleDisplayMode = .never
    }

    func configureMyTotalCoinBalance () {
        view.addSubview(myBalance)
        myBalance.translatesAutoresizingMaskIntoConstraints = false
        
        var totalBalance: Double = 0

        for coin in dataCount {
            if let coinCount = coin.coinCount, let lowPriceString = coin.lowPrice, let lowPriceDouble = Double(lowPriceString) {
                let totalPrice = coinCount * lowPriceDouble
                totalBalance += totalPrice
            }
        }
                
        myBalance.text = "Topla : \(Utils.formatCurrencyDouble(price: totalBalance))"

        NSLayoutConstraint.activate([
            myBalance.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            myBalance.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ])
        
        
    }
    
    func configureTableView() {
        tableView = UITableView(frame: .zero, style: .grouped)
        view.addSubview(tableView)
        
        tableView.register(UserWalletCell.self, forCellReuseIdentifier: UserWalletCell.reuseID)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        
        tableView.layer.cornerRadius = 10
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: myBalance.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
        ])
        
    }
}

extension FavoritesListScreen: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataCount.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserWalletCell.reuseID, for: indexPath) as! UserWalletCell
        cell.configure(coin: dataCount[indexPath.row])
        
        return cell
    }
}
