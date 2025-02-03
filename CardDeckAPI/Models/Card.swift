//
//  Card.swift
//  CardDeckAPI
//
//  Created by Samuel Lee on 2/3/25.
//


import Foundation

struct Card: Codable, Identifiable {
    let code: String
    let image: String
    let value: String
    let suit: String
    var isRevealed: Bool = false

    var id: String { code }
    
    private enum CodingKeys: String, CodingKey {
            case code, image, value, suit
        }
}
