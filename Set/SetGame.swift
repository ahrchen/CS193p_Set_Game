//
//  SetGame.swift
//  Set
//
//  Created by Raymond Chen on 5/6/23.
//

import SwiftUI

struct SetGame<CardColor, CardShape, CardNums, CardShading> where CardNums: Equatable & Hashable, CardColor: Equatable & Hashable, CardShape: Equatable & Hashable, CardShading: Equatable & Hashable {
    
    private(set) var cards: Array<Card>
    private(set) var deck: Array<Card>
    private(set) var player1Score: Int = 0
    private(set) var player2Score: Int = 0
    private(set) var selectedPlayer: Int = 0
    private(set) var availableTimePlayer1: Int = 5
    private(set) var availableTimePlayer2: Int = 5
    private(set) var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    private var selectedCards: Array<Int> = [] {
        didSet {
            cards.indices.forEach{ cards[$0].isSelected = (selectedCards.contains($0)) }
        }
    }
    
    mutating func updateTimer(player: Int) {
        if player == 1 {
            if availableTimePlayer1 > 0 {
                availableTimePlayer1 -= 1
            }
        } else {
            if availableTimePlayer2 > 0 {
                availableTimePlayer2 -= 1
            }
        }
    }
    
    mutating func resetTimer() {
        availableTimePlayer1 = 5
        availableTimePlayer2 = 5
        selectedPlayer = 0
        refresh()
    }
    
    mutating func choose(_ card: Card) {
        if selectedPlayer > 0, let chosenIndex = cards.firstIndex(where: {$0.id == card.id}),
           !cards[chosenIndex].isMatched{
            refresh()
            guard let firstPotentialMatchIndex = selectedCards.first else {
                selectedCards.append(chosenIndex)
                return
            }
            
            guard firstPotentialMatchIndex != chosenIndex else {
                selectedCards.remove(at: 0)
                return
            }
            
            guard selectedCards.count >= 2 else {
                selectedCards.append(chosenIndex)
                return
            }
            let secondPotentialMatchIndex = selectedCards[1]
            
            guard secondPotentialMatchIndex != chosenIndex else {
                selectedCards.remove(at: 1)
                return
            }
            
            if isMatch(firstPotentialMatchIndex, secondPotentialMatchIndex, chosenIndex) {
                cards[firstPotentialMatchIndex].isMatched = true
                cards[secondPotentialMatchIndex].isMatched = true
                cards[chosenIndex].isMatched = true
                updateScore(player: selectedPlayer, by: 3)
            } else {
                cards[firstPotentialMatchIndex].failedToMatch = true
                cards[secondPotentialMatchIndex].failedToMatch = true
                cards[chosenIndex].failedToMatch = true
            }
            selectedCards.removeAll()
        }
    }
    
    mutating func refresh() {
        self.cards.removeAll(where: { card in
            card.isMatched
        })
        cards.indices.forEach { cards[$0].failedToMatch = false}
        
        // Remove invalid selected card indexes
        for i in 0..<selectedCards.count {
            if selectedCards[i] >= cards.count {
                selectedCards.remove(at: i)
            }
        }
    }
    
    mutating func dealThreeCards() {
        if isSetAvailable() {
            updateScore(player: selectedPlayer, by: -1)
        }
        
        self.cards.removeAll(where: { card in
            card.isMatched
        })
        cards.indices.forEach { cards[$0].failedToMatch = false}
        addThreeCards()
    }
        
    private mutating func addThreeCards() {
        if deck.count >= 3 {
            for _ in 0..<3 {
                var dealtCard = deck.removeLast()
                dealtCard.isDealt = true
                cards.append(dealtCard)
            }
        }
    }
    
    mutating func cheat() {
        self.cards.removeAll(where: { card in
            card.isMatched
        })
        
        for i in 0..<cards.count - 2 {
            for j in 0 ..< cards.count - 1 {
                for k in 0 ..< cards.count {
                    if i != j && i != k && j != k && isMatch(i, j, k){
                        cards[i].isMatched = true
                        cards[j].isMatched = true
                        cards[k].isMatched = true
                        return
                    }
                }
            }
        }
    }
    
    mutating func updateSelectedPlayer(_ selectedPlayer: Int) {
        self.selectedPlayer = selectedPlayer
    }
    
    private func isSetAvailable() -> Bool {
        for i in 0..<cards.count - 2 {
            for j in 0 ..< cards.count - 1 {
                for k in 0 ..< cards.count {
                    if i != j && i != k && j != k && isMatch(i, j, k){
                        return true
                    }
                }
            }
        }
        return false
    }
    
    private mutating func updateScore(player: Int, by addedValue: Int) {
        if player == 1 {
            player1Score += addedValue
        } else if player == 2 {
            player2Score += addedValue
        } else {
            return
        }
    }
    
    
    private func isMatch(_ firstIndex: Int, _ secondIndex: Int, _ thirdIndex: Int) -> Bool {
        let firstCard = cards[firstIndex], secondCard = cards[secondIndex], thirdCard = cards[thirdIndex]
        
        let allNumsSame = Set([firstCard.numShapeSeen, secondCard.numShapeSeen, thirdCard.numShapeSeen]).count == 1
        let allNumsDifferent = Set([firstCard.numShapeSeen, secondCard.numShapeSeen, thirdCard.numShapeSeen]).count == 3
        
        let allShapeSame = Set([firstCard.shape, secondCard.shape, thirdCard.shape]).count == 1
        let allShapeDifferent = Set([firstCard.shape, secondCard.shape, thirdCard.shape]).count == 3
        
        let allShadingSame = Set([firstCard.shading, secondCard.shading, thirdCard.shading]).count == 1
        let allShadingDifferent = Set([firstCard.shading, secondCard.shading, thirdCard.shading]).count == 3
        
        let allColorSame = Set([firstCard.color, secondCard.color, thirdCard.color]).count == 1
        let allColorDifferent = Set([firstCard.color, secondCard.color, thirdCard.color]).count == 3
        
        return (allNumsSame || allNumsDifferent) && (allShapeSame || allShapeDifferent) && (allShadingSame || allShadingDifferent) && (allColorSame || allColorDifferent)
        
    }
    
    init(numColors: Int, numShapes: Int, numTimes: Int, numShades: Int,  createCardContent: (Int, Int, Int, Int) -> (CardColor, CardShape, CardNums, CardShading)) {
        deck = []
        cards = []
        var myCounter = 0
        for i in 0..<numShapes {
            for j in 0..<numShades {
                for k in 0 ..< numColors {
                    for l in 0 ..< numTimes {
                        let (color, shape, numTimeSeen, shading) = createCardContent(i,j,k,l)
                        deck.append(Card(shape: shape, color: color, numShapeSeen: numTimeSeen, shading: shading, id: myCounter))
                        myCounter += 1
                    }
                }
            }
        }
        deck.shuffle()
        while cards.count < 12 {
            addThreeCards()
        }
    }
    
    struct Card: Identifiable {
        var isMatched = false
        var isSelected = false
        var isDealt = false
        var failedToMatch = false
        let shape: CardShape
        let color: CardColor
        let numShapeSeen: CardNums
        let shading: CardShading
        let id: Int
        
        
    }
}

extension Array {
    var oneOrTwo: Element? {
        if self.count == 1 || self.count == 2 {
            return self.first
        } else {
            return nil
        }
    }
    
    var oneAndOnly: Element? {
        if self.count == 1 {
            return self.first
        } else {
            return nil
        }
    }
}
