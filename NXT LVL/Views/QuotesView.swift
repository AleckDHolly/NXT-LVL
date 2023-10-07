//
//  Quotes.swift
//  NXT LVL
//
//  Created by Aleck Holly on 2022-12-05.
//

import SwiftUI


struct QuotesView: View {
    
    @State var imageNumber = Int.random(in: 1...33)
    @ObservedObject var quotesManager = QuotesViewModel()
    @State var disabledButton = false
    @State var hasFetchedData = false
    
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                VStack {
                    if let quote = quotesManager.quote {
                        Text(quote[0].quote)
                            .font(.title2)
                            .fontWeight(.medium)
                            .multilineTextAlignment(.leading)
                            .padding(.all, 7.5)
                        HStack {
                            Spacer()
                            Text(quote[0].author ?? "Unknown")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.trailing)
                                .padding(.all, 7.5)
                        }
                    } else {
                        ProgressView("Loading...")
                            .progressViewStyle(CircularProgressViewStyle())
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
                        disabledButton = false
                        quotesManager.fetchData()
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
            .background(Color.clear)
            .padding(.bottom, 15)
        }
        .onAppear{
            if !hasFetchedData {
                quotesManager.fetchData()
                hasFetchedData = true
            }
        }
        .background(
            Image(String(imageNumber))
                .resizable(capInsets: EdgeInsets()).aspectRatio(contentMode: .fill).opacity(0.95).edgesIgnoringSafeArea(.all)
        )
    }
    
    func addQuote() {
        let newQuote = Quote(context: QuotesDataController.sharedInstance.container.viewContext)
        newQuote.quote = quotesManager.quote?[0].quote
        newQuote.author = quotesManager.quote?[0].author ?? "Unknown"
        QuotesDataController.sharedInstance.saveData()
    }
    
    func disableButton() {
        for quote in QuotesDataController.sharedInstance.savedQuotes {
            if quote.quote == quote.quote {
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
