//
//  CurrenciesViewModel.swift
//  Currencies_mvc
//
//  Created by Gökhan Gökoğlan on 5.07.2023.
//

import Foundation

class CurrenciesViewModel {
    private let apiManager: APIManager
    
    var currencies: [Currency] = []
    
    init(apiManager: APIManager = APIManager.shared) {
        self.apiManager = apiManager
    }
    
    func fetchCurrencies(completion: @escaping (Error?) -> Void) {
        apiManager.fetchCurrencies { [weak self] (fetchedCurrencies, error) in
            if let error = error {
                completion(error)
                return
            }
            
            if let fetchedCurrencies = fetchedCurrencies {
                self?.currencies = fetchedCurrencies
                completion(nil)
            }
        }
    }
}
