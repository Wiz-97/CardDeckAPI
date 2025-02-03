//
//  CardListView.swift
//  CardDeckAPI
//
//  Created by Samuel Lee on 2/3/25.
//


import SwiftUI

struct CardListView: View {
    @StateObject var viewModel = CardViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.cards) { card in
                        NavigationLink(destination: GuessView(card: card, viewModel: viewModel)) {
                            CardRow(card: card)
                        }
                        .disabled(card.isRevealed)
                    }

                    if viewModel.isLoading {
                        ProgressView("Loading more cards...")
                    } else {
                        Button("Load More") {
                            Task {
                                await viewModel.fetchMoreCards()
                            }
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Guess the Card")
        }
    }
}

#Preview {
    CardListView()
}

