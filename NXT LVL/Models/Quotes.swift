//
//  QuoteData.swift
//  NXT LVL
//
//  Created by Aleck Holly on 2022-12-06.
//


import Foundation

struct Quotes: Codable, Identifiable {
    var id: String {
        return quote
    }
    var quote: String
    var author: String?
    
}






