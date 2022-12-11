//
//  NetworkManager.swift
//  NXT LVL
//
//  Created by Aleck Holly on 2022-12-06.
//

import Foundation

class NetworkManager: ObservableObject {
    
    @Published var quotes = [Results]()
    
    func fetchData() {
        if let url = URL(string: "https://type.fit/api/quotes") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let results = try decoder.decode([Results].self, from: safeData)
                            DispatchQueue.main.async {
                                self.quotes = results
                            }
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            task.resume()
        }
    }
}
