//
//  CoinService.swift
//  CoinCase
//
//  Created by Osman Murat Haslak on 25.11.2022.
//

import Foundation

final class CoinService {
    
    func downloadCoins(completion: @escaping ([CoinsResult]?) -> () ) {
        guard let url = URL(string: APIURLs.getCoinPair()) else { return }
        NetworkManager.shared.download(url: url) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                completion(self.handleWithData(data))
            case .failure(let error):
                self.handleWithError(error)
            }
            
        }
    }
    
    private func handleWithError(_ error:Error) {
        print(error.localizedDescription)
    }
    
    private func handleWithData(_ data:Data) -> [CoinsResult]? {
        do {
            let coin = try JSONDecoder().decode([CoinsResult].self, from: data)
            return coin
        } catch  {
            print(error)
            return nil
        }
    }
    
}
