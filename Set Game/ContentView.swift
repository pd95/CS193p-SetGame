//
//  ContentView.swift
//  Set Game
//
//  Created by Philipp on 02.06.20.
//  Copyright © 2020 Philipp. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var model = SetGameViewModel()

    var body: some View {
        VStack {
            Text("SET")
                .font(.largeTitle)

            Text(model.statusText)

            Grid(self.model.cards) { card in
                CardView(card: card)
                    .zIndex(card.isSelected ? 2:1)
                    .padding(max(0, CGFloat(-self.model.cards.count) + 24))
                    .onTapGesture {
                        withAnimation {
                            self.model.choose(card)
                        }
                    }
                    .transition(.offset(self.randomOffset))
            }
            .onAppear {
                self.newGame()
            }


            Button(action: dealMoreCards) {
                Text("Deal 3 More Cards")
                    .padding()
            }
            .disabled(model.cardsRemaining == 0)

            Button(action: newGame) {
                Text("New Game")
                    .padding()
            }
        }
    }

    var randomOffset: CGSize {
        let size = UIScreen.main.bounds.size

        let signs: [CGFloat] = [-1, 1]
        let x: CGFloat = .random(in: 0..<size.width) * signs.randomElement()!
        let y: CGFloat = .random(in: 0..<size.height) * signs.randomElement()!

        return CGSize(width: x, height: y)
    }

    func dealMoreCards() {
        withAnimation {
            self.model.drawCard(3)
        }
    }

    func newGame() {
        withAnimation(.easeInOut) {
            self.model.newGame()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
