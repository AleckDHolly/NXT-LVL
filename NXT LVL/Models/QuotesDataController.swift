//
//  QuotesDataController.swift
//  NXT LVL
//
//  Created by Aleck Holly on 2022-12-11.
//

import Foundation
import CoreData

class QuotesDataController: ObservableObject {
    let container = NSPersistentContainer(name: "DataModel")
    @Published var savedQuotes: [Quote] = []
    static let sharedInstance = QuotesDataController()
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Failed to load: \(error.localizedDescription)")
            }
        }
        fetchQuotes()
    }
    
    func fetchQuotes() {
        let request = NSFetchRequest<Quote>(entityName: "Quote")
        do{
            savedQuotes = try container.viewContext.fetch(request).reversed()
        } catch {
            print("Error fetching. \(error)")
        }
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
            fetchQuotes()
        } catch let error {
            print("Error saving. \(error)")
        }
    }
    
    func deleteQuote(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let quote = savedQuotes[index]
        container.viewContext.delete(quote)
        saveData()
    }
    
}
