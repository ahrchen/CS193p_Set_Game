//
//  SetGame.swift
//  Set
//
//  Created by Raymond Chen on 5/6/23.
//

import SwiftUI

struct SetGame<CardColor, CardShape, CardNums, CardShading> {
    private(set) var cards: Array<Card>
    
    init(numColors: Int, numShapes: Int, numTimes: Int, numShades: Int,  createCardContent: (Int, Int, Int, Int) -> (CardColor, CardShape, CardNums, CardShading)) {
        cards = []
        var myCounter = 0
        for i in 0..<numShapes {
            for j in 0..<numShades {
                for k in 0 ..< numColors {
                    for l in 0 ..< numTimes {
                        let (color, shape, numTimeSeen, shading) = createCardContent(i,j,k,l)
                        cards.append(Card(shape: shape, color: color, numTimeSeen: numTimeSeen, shading: shading, id: myCounter))
                        myCounter += 1
                    }
                }
            }
        }
        
    }
    
    struct Card: Identifiable {
        var isMatched = false
        let shape: CardShape
        let color: CardColor
        let numTimeSeen: CardNums
        let shading: CardShading
        let id: Int
    }
}
