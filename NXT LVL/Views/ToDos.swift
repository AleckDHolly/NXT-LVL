//
//  ToDos.swift
//  NXT LVL
//
//  Created by Aleck Holly on 2022-12-05.
//

import SwiftUI

struct ToDos: View {
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        
                    }
                    , label: {
                        Image(systemName: "plus")
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
            .padding(.bottom, 15)
        }
        .background(Image("Home").resizable(capInsets: EdgeInsets()).aspectRatio(contentMode: .fill).opacity(0.95).edgesIgnoringSafeArea(.all))
    }
    
}

struct ToDos_Previews: PreviewProvider {
    static var previews: some View {
        ToDos()
    }
}

