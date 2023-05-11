//
//  ShapeBuilder.swift
//  Set
//
//  Created by Raymond Chen on 5/10/23.
//

import SwiftUI

struct ShapeBuilder {
    func buildShape(card: RegularSetGame.Card) -> any View {
        switch card.shape{
            case .diamond:
                return Diamond()
                    .fill(card.color)
            case .squiggle:
                return Squiggle()
                    .fill(card.color)
            case .oval:
                return Oval(cornerRadius: 5)
                    .fill(card.color)
        }
    }
}


//                    .fill(LinearGradient(gradient: Gradient(stops: [.init(color: .black, location: 0), .init(color: .white, location: 0.1), .init(color: .black, location: 0.2), .init(color: .white, location: 0.3), .init(color: .black, location: 0.4), .init(color: .white, location: 0.5), .init(color: .black, location: 0.6), .init(color: .white, location: 0.7), .init(color: .black, location: 0.8), .init(color: .white, location: 0.9), .init(color: .black, location: 1)]), startPoint: .leading, endPoint: .trailing))
