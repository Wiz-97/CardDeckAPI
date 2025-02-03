//
//  CardRow.swift
//  CardDeckAPI
//
//  Created by Samuel Lee on 2/3/25.
//


import SwiftUI

struct CardRow: View {
    let card: Card
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: card.isRevealed ? card.image : "https://deckofcardsapi.com/static/img/back.png")) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 60, height: 90)

            Text(card.isRevealed ? "\(card.value) of \(card.suit)" : "???")
                .font(.title)
            
            Spacer()
        }
        .padding()
    }
}
