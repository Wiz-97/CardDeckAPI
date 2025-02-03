//
//  GuessView.swift
//  CardDeckAPI
//
//  Created by Samuel Lee on 2/3/25.
//


import SwiftUI

struct GuessView: View {
    @State private var userGuess = ""
    let card: Card
    @ObservedObject var viewModel: CardViewModel
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            Text("Guess the Card!")
                .font(.largeTitle)
            
            TextField("Enter your guess (e.g. Ace of Hearts)", text: $userGuess)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Submit Guess") {
                revealCard()
            }
            .padding()
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
    
    func revealCard() {
        viewModel.revealCard(card: card)
        presentationMode.wrappedValue.dismiss()
    }
}
