//
//  CardView.swift
//  Set Game
//
//  Created by Philipp on 03.06.20.
//  Copyright © 2020 Philipp. All rights reserved.
//

import SwiftUI

struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let edge = min(rect.width, rect.height)/2

        path.move(to: CGPoint(x: center.x, y: center.y-edge))
        path.addLine(to: CGPoint(x: center.x-edge, y: center.y))
        path.addLine(to: CGPoint(x: center.x, y: center.y+edge))
        path.addLine(to: CGPoint(x: center.x+edge, y: center.y))
        path.addLine(to: CGPoint(x: center.x, y: center.y-edge))

        return path
    }
}

struct CardView: View {
    let card: SetGame.Card

    private let cornerRadius: CGFloat = 10
    private let edgeLineWidth: CGFloat = 2

    var body: some View {
        GeometryReader { (proxy) in
            self.body(for: proxy.size)
        }
    }

    func body(for size: CGSize) -> some View{
        let factor = min(max(0.1, max(size.width, size.height) / 145), 1)
        let symbolCount = card.number.rawValue
        print(size, factor)
        return ZStack {
            // Background with shadow
            Group {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(Color.white)
                    .shadow(color: card.isMatched ? Color.yellow : Color.black, radius: card.isSelected ? 10 * factor : 0)

                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(lineWidth: edgeLineWidth)

                VStack {
                    ForEach(0..<symbolCount) { _ in
                        self.symbol
                    }
                }
                .padding((4.0 - CGFloat(symbolCount)) * 4)
                .opacity(opacity)
            }
        }
        .foregroundColor(cardColor)
        .aspectRatio(1, contentMode: .fit)
        .padding(10 * factor)
        .scaleEffect(card.isSelected ? 1.2 : 1)
    }

    var symbol: some View {
        Group {
            if card.shape == .diamond {
                if card.shading == .outlined {
                    Diamond()
                        .stroke(lineWidth: 3)
                }
                else {
                    Diamond()
                        .fill()
                }
            }
            if card.shape == .oval {
                if card.shading == .outlined {
                    Circle()
                        .stroke(lineWidth: 3)
                }
                else {
                    Circle()
                        .fill()
                }
            }
            if card.shape == .squiggle {
                if card.shading == .outlined {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(lineWidth: 3)
                }
                else {
                    RoundedRectangle(cornerRadius: 5)
                        .fill()
                }
            }
        }
    }

    var cardColor: Color {
        switch card.color {
            case .red:
                return Color.red
            case .purple:
                return Color.purple
            case .green:
                return Color.green
        }
    }

    var opacity: Double {
        card.shading == .stripped ? 0.3 : 1.0
    }
}


struct CardView_Previews: PreviewProvider {
    static let game = SetGameViewModel()
    static var previews: some View {
        game.drawCard(1)
        let card = game.cards.first!

        return CardView(card: card)
            .previewLayout(.fixed(width: 200, height: 200))
    }
}
