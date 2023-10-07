//
//  TabBar.swift
//  NXT LVL
//
//  Created by Aleck Holly on 2022-12-05.
//

import SwiftUI

struct TabBar: View {
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor(red: 0.50, green: 0.50, blue: 0.50, alpha: 0.5)
       }
    
    var body: some View {
        TabView {
            Notes()
                .tabItem {
                    Image(systemName: "list.bullet.clipboard")
                    Text("Notes")
                }
            QuotesView()
                .tabItem {
                    Image(systemName: "airplane.departure")
                    Text("Quotes")
                }
            FavQuotes()
                .tabItem {
                    Image(systemName: "star.circle.fill")
                    Text("Favorite Quotes")
                }
        }
        .font(.headline)
        .accentColor(Color("ReverseAccColor"))
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
