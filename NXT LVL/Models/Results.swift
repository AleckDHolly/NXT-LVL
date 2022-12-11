//
//  QuoteData.swift
//  NXT LVL
//
//  Created by Aleck Holly on 2022-12-06.
//

import Foundation

struct Results: Codable, Identifiable {
    var id: String {
        return text
    }
    var text: String
    var author: String?
    
}

class Items {
    static let sharedInstance = Items()
    var array = [Results]()
}

