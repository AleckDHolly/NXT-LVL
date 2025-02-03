//
//  NetworkManager.swift
//  NXT LVL
//
//  Created by Aleck Holly on 2022-12-06.
//

import Foundation

class QuotesViewModel: ObservableObject {
    @Published var quote: [QuotesModel]?
    
    func fetchData() {
        let url = URL(string: "https://api.api-ninjas.com/v1/quotes")!
        var request = URLRequest(url: url)
        request.setValue("2h0OlqjwmbKls3G4CuUpGAgOY6vJW5ieQYfjTxKb", forHTTPHeaderField: "X-Api-Key")
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            guard let data = data else { 
                print("No data received from the API")
                return }
            let decoder = JSONDecoder()
            if let quote = try? decoder.decode([QuotesModel].self, from: data) {
                DispatchQueue.main.async {
                    self.quote = quote
                }
            }
        }
        task.resume()
    }
}

