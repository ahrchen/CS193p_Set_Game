//
//  Cardify.swift
//  Set
//
//  Created by Raymond Chen on 5/10/23.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    let card: RegularSetGame.Card
    
    init(card: RegularSetGame.Card) {
        rotation = card.isDealt ? 0 : 180
        self.card = card
    }
    
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
    var rotation: Double
    
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            if rotation < 90 {
                shape.fill(.white)
                shape.strokeBorder(
                    card.isSelected ?.blue : card.failedToMatch ? .red : card.isMatched ? .green : .black,
                    lineWidth: DrawingConstants.lineWidth
                )
            } else {
                shape.fill()
                shape.strokeBorder(.black,
            lineWidth: DrawingConstants.lineWidth)
            }
            content.opacity(rotation < 90 ? 1 : 0)
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (0,1,0))
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
