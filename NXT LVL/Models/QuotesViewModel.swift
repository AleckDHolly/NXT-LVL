//
//  NetworkManager.swift
//  NXT LVL
//
//  Created by Aleck Holly on 2022-12-06.
//

import Foundation

class QuotesViewModel: ObservableObject {
    @Published var quote: [QuotesModel]?
    private let categories: [String] = ["success", "life", "knowledge", "inspirational", "courage"]
    private var randomCategory: String {
            return categories.randomElement() ?? "knowledge"
        }
    
    func fetchData() {
        let url = URL(string: "https://api.api-ninjas.com/v1/quotes?category=\(randomCategory)")!
        var request = URLRequest(url: url)
        request.setValue("y8vl3FkpUqK2X19eN2VKZg==Pn51vKMEzT8NFWPr", forHTTPHeaderField: "X-Api-Key")
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

