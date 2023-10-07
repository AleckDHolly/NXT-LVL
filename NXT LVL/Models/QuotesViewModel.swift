//
//  NetworkManager.swift
//  NXT LVL
//
//  Created by Aleck Holly on 2022-12-06.
//

import Foundation

class MyDataViewModel: ObservableObject {
    @Published var quotes: Quotes?
    private let apiKey = "y8vl3FkpUqK2X19eN2VKZg==Pn51vKMEzT8NFWPr"
    private let category: [String] = ["success", "life", "knowledge", "inspirational", "courage"]
    private let randomCategory = Int.random(in: 0...4)

    func fetchData() {
        guard let url = URL(string: "https://api.api-ninjas.com/v1/quotes?category=\(category[randomCategory])") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("\(apiKey)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode(Quotes.self, from: data)
                    DispatchQueue.main.async {
                        self.quotes = decodedData
                    }
                } catch {
                    print("Error decoding data: \(error)")
                }
            }
        }.resume()
    }
}

