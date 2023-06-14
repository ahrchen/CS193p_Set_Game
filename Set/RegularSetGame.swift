//
//  RegularSetGame.swift
//  Set
//
//  Created by Raymond Chen on 5/6/23.
//

import Foundation
import SwiftUI
import Combine

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
    
    var deck: Array<Card> {
        return model.deck
    }
    
    // MARK: - Intents(s)
    
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    func addThreeCards() {
        model.dealThreeCards()
    }
    
    func getPlayerScore(_ player: Int) -> Int {
        if player == 1{
            return model.player1Score
        } else {
            return model.player2Score
        }
        
    }
    
    func updateSelectedPlayer(_ selectedPlayer: Int) {
        model.updateSelectedPlayer(selectedPlayer)
    }
    
    func getSelectedPlayer() -> Int {
        model.selectedPlayer
    }
    
    func newGame() {
        model = RegularSetGame.createSetGame()
    }
    
    func cheat() {
        model.cheat()
    }
    
    func updateTimer(player: Int) {
        model.updateTimer(player: player)
    }
    
    func resetTimer() {
        model.resetTimer()
    }
    
    func getTime(player: Int) -> Int {
        if player == 1 {
            return model.availableTimePlayer1
        } else {
            return model.availableTimePlayer2
        }
    }
    
    func getTimer() -> Publishers.Autoconnect<Timer.TimerPublisher> {
        model.timer
    }
}

enum Shading: Equatable {
    case solid, striped, open
}

enum CardShape: Equatable {
    case diamond , squiggle , oval
}

enum NumShapeSeen: Int, Equatable {
    case one = 1, two, three
}

