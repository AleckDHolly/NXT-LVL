//
//  FavQuotes.swift
//  NXT LVL
//
//  Created by Aleck Holly on 2022-12-05.
//

import SwiftUI

struct FavQuotes: View {
    
    @State var list = Items.sharedInstance.array
    let quotesView = QuotesView()
    
    init() {
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View{
        ZStack {
            NavigationView() {
                List(list) { quotation in
                    VStack {
                        //MANDATORY
                        Text(quotation.text)
                            .multilineTextAlignment(.leading)
                        HStack {
                            Spacer()
                            Text(quotation.author ?? "Unknown")
                                .multilineTextAlignment(.trailing)
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                .background(Image("Favs").resizable(capInsets: EdgeInsets()).aspectRatio(contentMode: .fill).opacity(0.95).edgesIgnoringSafeArea(.all))
                .navigationTitle("Favorite Quotes")
            }
        }.onAppear{
            loadData()
        }
    }
    
    func loadData() {
        if let data = try? Data(contentsOf: quotesView.dataFilePath!) {
            let decoder = PropertyListDecoder()
            do{
                Items.sharedInstance.array = try decoder.decode([Results].self, from: data)
                list = Items.sharedInstance.array
            } catch {
                print("Error decoding Quotes array, \(error)")
            }
        }
    }

}

struct FavQuotes_Previews: PreviewProvider {
    static var previews: some View {
        FavQuotes()
    }
}
