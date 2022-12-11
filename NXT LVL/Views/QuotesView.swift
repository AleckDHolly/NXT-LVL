//
//  Quotes.swift
//  NXT LVL
//
//  Created by Aleck Holly on 2022-12-05.
//

import SwiftUI


struct QuotesView: View {
    
    @State var imageNumber = Int.random(in: 1...33)
    @State var randomQuote = Int.random(in: 0...1642)
    @ObservedObject var networkManager = NetworkManager()
    @State var disabledButton = false
    
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                VStack {
                    Text(randomText())
                        .font(.title2)
                        .fontWeight(.medium)
                        .multilineTextAlignment(.leading)
                        .padding(.all, 7.5)
                    HStack {
                        Spacer()
                        Text(randomAuthor())
                            .font(.title2)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.trailing)
                            .padding(.all, 7.5)
                    }
                }
                .background(Color.gray.opacity(0.75))
                .cornerRadius(6.5)
                .padding(.all)
                Button("Save Quote") {
                    addQuote()
                    disableButton()
                }
                .padding(.all, 10.0)
                .foregroundColor(Color("AccentColor"))
                .background(Color("ReverseAccColor"))
                .cornerRadius(10)
                .disabled(disabledButton)
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        imageNumber = Int.random(in: 1...33)
                        randomQuote = Int.random(in: 0...1643)
                        disabledButton = false
                    }, label: {
                        Image(systemName: "arrow.counterclockwise")
                            .font(.system(.largeTitle))
                            .clipShape(Circle())
                            .frame(width: 60.0, height: 60.0)
                            .foregroundColor(Color("AccentColor"))
                            .padding(.all, 7)
                    })
                    .background(Color("ReverseAccColor"))
                    .cornerRadius(38.5)
                    .padding()
                    .shadow(color: .gray, radius: 5, x: 3, y: 3)
                }
            }
            .onAppear(perform: networkManager.fetchData)
            .background(Color.clear)
            .padding(.bottom, 15)
        }
        .background(
            Image(String(imageNumber))
                .resizable(capInsets: EdgeInsets()).aspectRatio(contentMode: .fill).opacity(0.95).edgesIgnoringSafeArea(.all)
        )
    }
    
    func randomText() -> String {
        var text: String = ""
        for _ in $networkManager.quotes {
            text = "\(networkManager.quotes[randomQuote].text)"
        }
        return text
    }

    func randomAuthor() -> String {
        var author: String = ""
        for _ in $networkManager.quotes {
            author = "\n-\(networkManager.quotes[randomQuote].author ?? "Unknown")"
        }
        return author
    }
    
    func addQuote() {
        let newQuote = Quote(context: QuotesDataController.sharedInstance.container.viewContext)
        newQuote.text = randomText()
        newQuote.author = randomAuthor()
        QuotesDataController.sharedInstance.saveData()
    }
    
    func disableButton() {
        for quote in QuotesDataController.sharedInstance.savedQuotes {
            if quote.text == quote.text {
                disabledButton = true
            }
        }
    }
    
}

struct Quotes_Previews: PreviewProvider {
    static var previews: some View {
        QuotesView()
    }
}
