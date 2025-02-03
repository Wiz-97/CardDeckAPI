//
//  CardViewModel.swift
//  CardDeckAPI
//
//  Created by Samuel Lee on 2/3/25.
//


import Foundation

@MainActor
class CardViewModel: ObservableObject {
    @Published var deckID: String = ""
    @Published var cards: [Card] = []
    @Published var isLoading = false

    init() {
        Task {
            await setupDeck()
        }
    }

    func setupDeck() async {
        do {
            deckID = try await createNewDeck()
            await fetchMoreCards()
        } catch {
            print("Error setting up deck:", error)
        }
    }

    func fetchMoreCards() async {
        guard !isLoading, !deckID.isEmpty else { return }
        isLoading = true
        
        do {
            let newCards = try await drawCards(deckID: deckID)
            DispatchQueue.main.async {
                self.cards.append(contentsOf: newCards)
                self.isLoading = false
            }
        } catch {
            print("Error fetching cards:", error)
            isLoading = false
        }
    }

    func revealCard(card: Card) {
        if let index = cards.firstIndex(where: { $0.id == card.id }) {
            cards[index].isRevealed = true
        }
    }

    private func createNewDeck() async throws -> String {
        let url = URL(string: "https://deckofcardsapi.com/api/deck/new/shuffle/?deck_count=1")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(DeckResponse.self, from: data)
        return response.deck_id
    }

    private func drawCards(deckID: String, count: Int = 10) async throws -> [Card] {
        let url = URL(string: "https://deckofcardsapi.com/api/deck/\(deckID)/draw/?count=\(count)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(DrawResponse.self, from: data)
        return response.cards
    }
}
