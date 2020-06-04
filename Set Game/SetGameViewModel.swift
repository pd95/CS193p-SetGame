//
//  SetGameViewModel.swift
//  Set Game
//
//  Created by Philipp on 03.06.20.
//  Copyright © 2020 Philipp. All rights reserved.
//

import SwiftUI

class SetGameViewModel: ObservableObject {
    @Published var model = SetGame()
    @Published var wasMatch: SetGame.State = .selectCard

    // MARK: - Access to the Model
    var cards: [SetGame.Card] {
        model.dealedCards
    }

    var cardsRemaining: Int {
        model.cardsRemainingInDeck
    }

    var statusText: String {
        switch wasMatch {
            case .selectCard:
                return "Choose card(s)"
            case .noMatch:
                return "Selected cards do not make a set."
            case .match:
                return "Well done! Cards match."
        }
    }

    // MARK: - Intent(s)
    func choose(_ card: SetGame.Card) {
        wasMatch = model.select(card: card)
    }

    func drawCard(_ number: Int = 1) {
        for _ in 0..<number {
            _ = model.addCard()
        }
    }

    func dealMoreCards() {
        drawCard(3)
    }

    func newGame() {
        model = SetGame()
        drawCard(12)
    }
}
