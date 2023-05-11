//
//  ShapeView.swift
//  Set
//
//  Created by Raymond Chen on 5/10/23.
//

import SwiftUI

struct ShapeView: View {
    let card: RegularSetGame.Card
    
    var body: some View {
        switch card.shape {
        case .diamond:
            switch card.shading {
                case .solid:
                    Diamond()
                    .fill(card.color)
                case .open:
                    Diamond()
                    .stroke(card.color)
                case .striped:
                    Diamond()
                    .fill(stripedColor(color: card.color))
            }
           
        case .squiggle:
            switch card.shading {
                case .solid:
                    Squiggle()
                    .fill(card.color)
                case .open:
                    Squiggle()
                    .stroke(card.color)
                case .striped:
                    Squiggle()
                    .fill(stripedColor(color: card.color))
            }
        case .oval:
            switch card.shading {
                case .solid:
                    Oval(cornerRadius: 5)
                    .fill(card.color)
                case .open:
                    Oval(cornerRadius: 5)
                    .stroke(card.color)
                case .striped:
                    Oval(cornerRadius: 5)
                    .fill(stripedColor(color: card.color))
            }
        }
    }
    
    func stripedColor(color: Color) -> LinearGradient {
        LinearGradient(gradient: Gradient(stops: [.init(color: color, location: 0), .init(color: .white, location: 0.1), .init(color: color, location: 0.2), .init(color: .white, location: 0.3), .init(color: color, location: 0.4), .init(color: .white, location: 0.5), .init(color: color, location: 0.6), .init(color: .white, location: 0.7), .init(color: color, location: 0.8), .init(color: .white, location: 0.9), .init(color: color, location: 1)]), startPoint: .leading, endPoint: .trailing)
    }
}
