//
//  RegularSetGame.swift
//  Set
//
//  Created by Raymond Chen on 5/6/23.
//

import Foundation
import SwiftUI

class RegularSetGame: ObservableObject {
    typealias Card = SetGame<Color, CardShape, NumShapeSeen, Shading>.Card
    
    static let availableColors: [Color] = [.red, .green, .purple]
    static let availableShapes: [CardShape] = [.diamond, .squiggle, .oval]
    static let availableNumTimesSeen: [NumShapeSeen] = [.one, .two, .three]
    static let availableShading: [Shading] = [.solid, .striped,.open]
    
    private static func createSetGame() -> SetGame<Color, CardShape, NumShapeSeen, Shading> {
        return SetGame<Color, CardShape, NumShapeSeen, Shading>(numColors: 3, numShapes: 3, numTimes: 3, numShades: 3) { colorIndex, shapeIndex, timesSeen, shadingIndex in
            (availableColors[colorIndex], availableShapes[shapeIndex], availableNumTimesSeen[timesSeen], availableShading[shadingIndex])
        }
    }
    
    @Published private var model = createSetGame()
    
    var cards: Array<Card> {
        return model.cards
    }
}


enum Shading {
    case solid, striped, open
}

enum CardShape {
    case diamond , squiggle , oval
}

enum NumShapeSeen: Int {
    case one = 1, two, three
}
