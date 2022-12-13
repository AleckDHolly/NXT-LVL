//
//  FavQuotes.swift
//  NXT LVL
//
//  Created by Aleck Holly on 2022-12-05.
//

import SwiftUI
import CoreData

struct FavQuotes: View {
    
    @State private var quotes: [Quote] = [Quote]()
    
    init() {
      if #unavailable(iOS 16.0) {
        UITableView.appearance().backgroundColor = .clear
      }
    }
    
    var body: some View{
        ZStack {
            NavigationView() {
                List {
                    ForEach(quotes) { quotation in
                        VStack {
                            Text(quotation.text!)
                                .multilineTextAlignment(.leading)
                            HStack {
                                Spacer()
                                Text(quotation.author ?? "Unknown")
                                    .multilineTextAlignment(.trailing)
                            }
                        }
                    }.onDelete{quote in
                        QuotesDataController.sharedInstance.deleteQuote(indexSet: quote)
                        populateQuotes()
                    }
                    Text("Swipe left to delete a quote..")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .foregroundColor(Color("lightGray"))
                }
                .clearListBackground()
                .background(Image("Favs").resizable(capInsets: EdgeInsets()).aspectRatio(contentMode: .fill).opacity(0.95).edgesIgnoringSafeArea(.all))
                .navigationTitle("Favorite Quotes")
            }
        }.onAppear{
            populateQuotes()
        }
    }
    
    private func populateQuotes() {
        quotes = QuotesDataController.sharedInstance.savedQuotes
    }
    
}

struct FavQuotes_Previews: PreviewProvider {
    static var previews: some View {
        FavQuotes()
    }
}
