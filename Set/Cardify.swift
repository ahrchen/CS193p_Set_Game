//
//  Cardify.swift
//  Set
//
//  Created by Raymond Chen on 5/10/23.
//

import SwiftUI

struct Cardify: ViewModifier {
    let card: RegularSetGame.Card
    
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            if card.isDealt {
                shape.fill(.white)
                shape.strokeBorder(
                    card.isSelected ?.blue : card.failedToMatch ? .red : card.isMatched ? .green : .black,
                    lineWidth: DrawingConstants.lineWidth
                )
            } else {
                shape.fill()
            }

            content.opacity(card.isDealt ? 1 : 0)
        }
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
    }
}

extension View {
    func cardify(card: RegularSetGame.Card) -> some View {
        return self.modifier(Cardify(card: card))
    }
}

struct Cardify_Previews: PreviewProvider {
    static var previews: some View {
        Text("🗿")
            .modifier(Cardify(card: RegularSetGame.Card(shape: .diamond, color: .green, numShapeSeen: .one, shading: .open, id: 1)))
    }
}
