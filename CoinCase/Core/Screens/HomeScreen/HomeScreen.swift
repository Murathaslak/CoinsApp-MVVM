//
//  HomeScreen.swift
//  CoinCase
//
//  Created by Osman Murat Haslak on 7.10.2023.
//

import UIKit


//SATIN ALMA İŞLEMLERİNİ BİTİR SATIN ALMA BAKİYE ÇALIŞIYOR SATMA KISIMLARINA BAK TEXTİ YANINA YAZDIR

protocol HomeScreenInterface: AnyObject {
    func configureVC()
    func configureNavigationBar()
//    func configureAppBar()
    func configureTableView()
    func reloadTableViewData()
    func configureBuySellButtonsCell()
    func configureTotalBalanceCell()
    func configureTextFields()
    func configureSubmitButton()
}

final class HomeScreen: UIViewController, UIScrollViewDelegate {
    
    private let viewModel = HomeViewModel()
    
    private var appBar = UIView()
    
    private var tableView = UITableView()
    
    private var last24hColumLabels = CustomColumLabels()
    
    private var totalBalanceLabel = IconLabelView()
            
    var selectedCoin = CoinsResult()
    var buySegment: Bool = true
        
    private var buyButton = CCButton(backgroundColor: .systemGreen, title: "AL", tag: 1)
    private var sellButton = CCButton(backgroundColor: .systemGray3, title: "SAT", tag: 2)
    private var submitButton = CCButton(backgroundColor: .systemGreen, title: "BTCTRY AL", tag: 3)
        
    let firstTextField = CCTextField(isEditing: false, placeHolderText: "BTC Miktarı")
    let secondTextField = CCTextField(isEditing: true, placeHolderText: "TOPLAM (TRY)")
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.view = self
        viewModel.viewDidLoad()
    }
}

extension HomeScreen: HomeScreenInterface {
    
    func configureNavigationBar() {
        
        let leftButton = UIButton(type: .system)
        let rightButton = UIButton(type: .system)
        let leftButtonItem = UIBarButtonItem(customView: leftButton)
        let rightButtonItem = UIBarButtonItem(customView: rightButton)
                
        title = "iOS Test Case"
        navigationController?.navigationBar.backgroundColor = .blue
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationItem.largeTitleDisplayMode = .never
        
        rightButton.addTarget(self, action: #selector(rightButtonTapped), for: .touchUpInside)

        leftButton.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        leftButton.tintColor = .white
        navigationItem.leftBarButtonItem = leftButtonItem

        rightButton.setImage(UIImage(systemName: "circle.grid.3x3.fill"), for: .normal)
        rightButton.tintColor = .white
        navigationItem.rightBarButtonItem = rightButtonItem

        navigationController?.navigationBar.layer.cornerRadius = 20
        navigationController?.navigationBar.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    
    func reloadTableViewData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func configureVC() {
        view.backgroundColor = .systemGray6
    }
    
//    func configureAppBar() {
//        let titleLabel = UILabel()
//        let backButton = UIButton(type: .system)
//        let leftButton = UIButton(type: .system)
//        
//        view.addSubview(appBar)
//        appBar.addSubview(backButton)
//        appBar.addSubview(titleLabel)
//        appBar.backgroundColor = .blue
//        appBar.layer.cornerRadius = 20
//        appBar.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
//        
//        titleLabel.text = "iOS Test Case"
//        titleLabel.textColor = UIColor.white
//        titleLabel.textAlignment = .center
//        
//        backButton.setImage(UIImage(systemName: "arrow.left"), for: .normal)
//        backButton.tintColor = UIColor.white
//        
//        leftButton.setImage(UIImage(systemName: "bitcoinsign.circle"), for: .normal)
//        leftButton.tintColor = UIColor.white
//        appBar.addSubview(leftButton)
//
//        appBar.translatesAutoresizingMaskIntoConstraints = false
//        titleLabel.translatesAutoresizingMaskIntoConstraints = false
//        backButton.translatesAutoresizingMaskIntoConstraints = false
//        leftButton.translatesAutoresizingMaskIntoConstraints = false
//        
//        leftButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
//
//        NSLayoutConstraint.activate([
//            appBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            appBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            appBar.heightAnchor.constraint(equalToConstant: 70),
//            appBar.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
//        ])
//        
//        NSLayoutConstraint.activate([
//            titleLabel.centerXAnchor.constraint(equalTo: appBar.centerXAnchor),
//            titleLabel.centerYAnchor.constraint(equalTo: appBar.centerYAnchor)
//        ])
//        
//        NSLayoutConstraint.activate([
//            backButton.leadingAnchor.constraint(equalTo: appBar.leadingAnchor, constant: 16),
//            backButton.centerYAnchor.constraint(equalTo: appBar.centerYAnchor)
//        ])
//        
//        NSLayoutConstraint.activate([
//            leftButton.trailingAnchor.constraint(equalTo: appBar.trailingAnchor, constant: -16),
//            leftButton.centerYAnchor.constraint(equalTo: appBar.centerYAnchor)
//        ])
//    }
    
    func configureTableView() {
        tableView = UITableView(frame: .zero, style: .grouped)
        view.addSubview(tableView)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.reuseID)

        tableView.layer.cornerRadius = 10

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tableView.heightAnchor.constraint(equalToConstant: 300),
        ])
    }
    
    func configureBuySellButtonsCell() {
        view.addSubview(buyButton)
        view.addSubview(sellButton)
        view.addSubview(last24hColumLabels)
        
        buyButton.tag = 1
        sellButton.tag = 2
        
        buyButton.addTarget(self, action: #selector(buyButtonTapped), for: .touchUpInside)
        sellButton.addTarget(self, action: #selector(sellButtonTapped), for: .touchUpInside)
        
        buyButton.translatesAutoresizingMaskIntoConstraints = false
        sellButton.translatesAutoresizingMaskIntoConstraints = false
        last24hColumLabels.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            buyButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 40),
            buyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            buyButton.heightAnchor.constraint(equalToConstant: 30),
            buyButton.widthAnchor.constraint(equalToConstant: 80)
        ])
        
        NSLayoutConstraint.activate([
            sellButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 40),
            sellButton.leadingAnchor.constraint(equalTo: buyButton.trailingAnchor, constant: 10),
            sellButton.heightAnchor.constraint(equalToConstant: 30),
            sellButton.widthAnchor.constraint(equalToConstant: 80)
        ])
        
        NSLayoutConstraint.activate([
            last24hColumLabels.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 40),
            last24hColumLabels.heightAnchor.constraint(equalToConstant: 30),
            last24hColumLabels.leadingAnchor.constraint(equalTo: sellButton.trailingAnchor, constant: 20),
            last24hColumLabels.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
    }
    
    func configureTotalBalanceCell() {
        view.addSubview(totalBalanceLabel)
        totalBalanceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            totalBalanceLabel.topAnchor.constraint(equalTo: buyButton.bottomAnchor, constant: 20),
            totalBalanceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            totalBalanceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            totalBalanceLabel.heightAnchor.constraint(equalToConstant: 30),
            totalBalanceLabel.bottomAnchor.constraint(equalTo: firstTextField.topAnchor, constant: -5),
            
        ])
    }
            
    func configureTextFields() {
        view.addSubview(firstTextField)
        view.addSubview(secondTextField)
        
        let toolbar = UIToolbar()
        
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Tamam", style: .plain, target: self, action: #selector(doneButtonTapped))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.items = [flexibleSpace, doneButton]
        
        secondTextField.keyboardType = .numberPad
        secondTextField.returnKeyType = .done
        secondTextField.inputAccessoryView = toolbar
        secondTextField.translatesAutoresizingMaskIntoConstraints = false
        secondTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)

        firstTextField.translatesAutoresizingMaskIntoConstraints = false
                
        NSLayoutConstraint.activate([
            firstTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            firstTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            firstTextField.heightAnchor.constraint(equalToConstant: 50),
            
            secondTextField.topAnchor.constraint(equalTo: firstTextField.bottomAnchor, constant: 10),
            secondTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            secondTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            secondTextField.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    func configureSubmitButton() {
        view.addSubview(submitButton)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        
        submitButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            submitButton.topAnchor.constraint(equalTo: secondTextField.bottomAnchor, constant: 40),
            submitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            submitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            submitButton.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        
    }
    
    func performBuyOperation(_ secondAmount:Double,_ firstAmountText: String) {
        
        if secondAmount > totalBalanceLabel.balance {
            presentGFAlertOnMainThread(title: "Uyarı!!", message: CCError.yetersizTutar.rawValue, buttonTitle: "Tamam")
            return
        }
        
        if totalBalanceLabel.balance - secondAmount < 0 {
            presentGFAlertOnMainThread(title: "Uyarı!!", message: CCError.yetersizBakiye.rawValue, buttonTitle: "Tamam")
            return
        }
        
        if totalBalanceLabel.balance <= 0 {
            presentGFAlertOnMainThread(title: "Uyarı!!", message: CCError.yetersizBakiye.rawValue, buttonTitle: "Tamam")
            return
        }
        
        totalBalanceLabel.balance -= secondAmount
        
        if let doubleValue = Double(firstAmountText.components(separatedBy: " ").first ?? "") {
            if let selectedCoinIndex = viewModel.coins.firstIndex(where: { $0.symbol == selectedCoin.symbol }) {
                var updatedCoin = viewModel.coins[selectedCoinIndex]
                updatedCoin.coinCount! += doubleValue
                totalBalanceLabel.setCount += doubleValue
                viewModel.coins[selectedCoinIndex] = updatedCoin
            }
        }
        
        presentGFAlertOnMainThread(title: "Uyarı!!", message: CCError.basariliSatinAlma.rawValue, buttonTitle: "Tamam")
        secondTextField.text = ""
        firstTextField.text = ""
    }

    func performSellOperation() {
        let satilanCoinAdet = Double(firstTextField.text?.components(separatedBy: " ").first ?? "") ?? 0
        let satilanCoinTutar = Double(secondTextField.text?.components(separatedBy: " ").first ?? "") ?? 0

        guard let coinCountText = totalBalanceLabel.coinCountLabel.text,
              let mevcutAdet = Double(coinCountText) else {
            presentGFAlertOnMainThread(title: "Uyarı!!", message: CCError.hataliCoinMiktarTutar.rawValue, buttonTitle: "Tamam")
            return
        }
                
        if mevcutAdet - satilanCoinAdet < 0 {
            presentGFAlertOnMainThread(title: "Uyarı!!", message: CCError.yetersizCoin.rawValue, buttonTitle: "Tamam")
            secondTextField.text = ""
            firstTextField.text = ""
            return
        } else if mevcutAdet > 0  {
            
            if let selectedCoinIndex = viewModel.coins.firstIndex(where: { $0.symbol == selectedCoin.symbol }) {
                var updatedCoin = viewModel.coins[selectedCoinIndex]
                let kalanCoinSayisi = mevcutAdet - satilanCoinAdet
                updatedCoin.coinCount! -= kalanCoinSayisi
                totalBalanceLabel.setCount = kalanCoinSayisi
                totalBalanceLabel.balance += satilanCoinTutar
                viewModel.coins[selectedCoinIndex] = updatedCoin
                
            }

            presentGFAlertOnMainThread(title: "Uyarı!!", message: CCError.basariliCoinSatis.rawValue, buttonTitle: "Tamam")
            secondTextField.text = ""
            firstTextField.text = ""


        } else {
            presentGFAlertOnMainThread(title: "Uyarı!!", message: CCError.yetersizCoin.rawValue, buttonTitle: "Tamam")
        }
    }
    
    func setFields(selectedCoin: CoinsResult) {
           if let enteredAmountText = secondTextField.text,
              let enteredAmount = Double(enteredAmountText),
              let currentHighPriceText = selectedCoin.highPrice,
              let currentHighPrice = Double(currentHighPriceText) {
               
               let btcAmount = enteredAmount / currentHighPrice
               let formattedAmount = String(format: "%.5f", btcAmount)
               firstTextField.text = "\(formattedAmount)"
           }
           
           let symbolWithoutLast3Characters = String(selectedCoin.symbol!.dropLast(3))
           firstTextField.placeholder = "\(symbolWithoutLast3Characters) Miktarı"
            
        if (buySegment) {
            submitButton.setTitle(symbolWithoutLast3Characters + " AL", for: .normal)
        } else {
            submitButton.setTitle(symbolWithoutLast3Characters + " SAT", for: .normal)
        }
        
        totalBalanceLabel.coinCountLabel.text = "\(selectedCoin.coinCount!)"
        
        last24hColumLabels.subtitleLabelHigh.text = Utils.formatCurrency(price: selectedCoin.highPrice!)
           last24hColumLabels.subtitleLabelLow.text = Utils.formatCurrency(price: selectedCoin.lowPrice!)
       }
    
    @objc func doneButtonTapped() {
        secondTextField.resignFirstResponder()
    }

    @objc func rightButtonTapped() {
        let detailVC = FavoritesListScreen()
        let myCoins = viewModel.coins.filter { coinResult in
            return coinResult.coinCount ?? 0 > 0
        }
        detailVC.dataCount = myCoins
               navigationController?.pushViewController(detailVC, animated: true)
        print("asd")
    }
        
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField == secondTextField {
            if let text = textField.text, !text.isEmpty {
                if let number = Double(text), let lowPrice = selectedCoin.lowPrice {
                    let result = number / Double(lowPrice)!
                    let formattedAmount = String(format: "%.5f", result)
                    let symbolWithoutLast3Characters = String(selectedCoin.symbol!.dropLast(3))

                    firstTextField.text = "\(formattedAmount) \(symbolWithoutLast3Characters) Miktarı"
                } else {
                    presentGFAlertOnMainThread(title: "Uyarı!!", message: CCError.uyari.rawValue, buttonTitle: "Tamam")
                    secondTextField.text = ""
                }
            } else {
                secondTextField.text = ""
            }
        }
    }

    @objc func buyButtonTapped(sender: UIButton) {
        buySegment = true
        buyButton.backgroundColor = .systemGreen
        sellButton.backgroundColor = .systemGray3
        submitButton.backgroundColor = .systemGreen
        submitButton.setTitle("", for: .normal)
        submitButton.setTitle((selectedCoin.symbol?.dropLast(3) ?? "BTCTRY") + " AL", for: .normal)
    }
    
    @objc func sellButtonTapped(sender: UIButton) {
        buySegment = false
        buyButton.backgroundColor = .systemGray3
        sellButton.backgroundColor = .systemRed
        submitButton.backgroundColor = .systemRed
        submitButton.setTitle("", for: .normal)
        submitButton.setTitle((selectedCoin.symbol?.dropLast(3) ?? "BTCTRY") + " SAT", for: .normal)
    }
    
    @objc func submitButtonTapped() {
        guard let firstAmountText = firstTextField.text,
              let secondAmountText = secondTextField.text,
              !firstAmountText.isEmpty,
              !secondAmountText.isEmpty else {
            presentGFAlertOnMainThread(title: "Uyarı!!", message: CCError.gerekliAlan.rawValue, buttonTitle: "Tamam")
            return
        }
        
        guard let secondAmount = Double(secondAmountText) else {
            presentGFAlertOnMainThread(title: "Uyarı!!", message: CCError.gecerliMiktar.rawValue, buttonTitle: "Tamam")
            return
        }

        if buySegment {
            performBuyOperation(secondAmount, firstAmountText)
        } else {
            performSellOperation()
        }
    }

}

extension HomeScreen: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.reuseID, for: indexPath) as! CustomTableViewCell
        cell.configure(coin: viewModel.coins[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedCoin = viewModel.coins[indexPath.row]
        self.setFields(selectedCoin: selectedCoin)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Coin List"
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        0
    }
    
}
