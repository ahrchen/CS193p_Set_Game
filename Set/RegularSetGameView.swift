//
//  ContentView.swift
//  Set
//
//  Created by Raymond Chen on 5/6/23.
//

import SwiftUI

struct RegularSetGameView: View {
    
    @ObservedObject var game: RegularSetGame
    
    var body: some View {
        PlayerView(game: game, player: 1)
        AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
            CardView(card: card)
                .padding(2)
                .onTapGesture {
                    game.choose(card)
                }
        }
        HStack {
            deckBody
            discardBody
        }
        PlayerView(game: game, player: 2)
        Divider()
        HStack {
            Button("Deal 3 More Cards") {
            game.addThreeCards()
            }
            .disabled(game.deck.isEmpty)
            Spacer()
            Button("New Game") {
                game.newGame()
            }
            Spacer()
            Button("Cheat") {
                game.cheat()
            }
        }
        .padding(5)
    }
    
    // Deck body
    var deckBody: some View {
        ZStack {
            ForEach(game.cards.filter(isUndealt)) { card in
                CardView(card: card)
            }
        }
        .frame(width: CardConstants.undealtWidth, height: CardConstants.undealtHeight)
    }
    
    // Discard body
    var discardBody: some View {
        ZStack {
            ForEach(game.cards.filter({card in card.isMatched})) { card in
                CardView(card: card)
            }
        }
        .frame(width: CardConstants.undealtWidth, height: CardConstants.undealtHeight)
    }
    
    private struct CardConstants {
        static let aspectRatio: CGFloat = 2/3
        static let undealtWidth = undealtHeight * aspectRatio
        static let undealtHeight: CGFloat = 90
    }
    
    @State private var dealt = Set<Int>()
    
    private func deal(_ card: RegularSetGame.Card) {
        dealt.insert(card.id)
    }
    
    private func isUndealt(_ card: RegularSetGame.Card) -> Bool {
        !dealt.contains(card.id)
    }
}

// Player View

struct PlayerView: View {
    @ObservedObject var game: RegularSetGame
    let player: Int
    
    var body: some View {
        HStack {
            Spacer()
            Button("Player \(player)") {
                    game.updateSelectedPlayer(player)
                
            }.disabled(game.getSelectedPlayer() > 0)
                .foregroundColor(game.getSelectedPlayer() == player ? .red : .blue)
            Divider()
            Text("Points \(game.getPlayerScore(player))")
            Divider()
            Text("Time Remaining \(game.getTime(player: player))").onReceive(game.getTimer()) { time in
                if game.getSelectedPlayer() == player {
                    game.updateTimer(player: player)
                }
                if game.getTime(player: player) == 0 {
                    game.resetTimer()
                }
            }
            Spacer()
        }
        .frame(height: 20)
    }
}


// Create Set Cards
struct CardView: View {
    let card: RegularSetGame.Card
    
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                VStack {
                    CardContentView(card: card)
                }
            }
        }
        .cardify(card: card)
        
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 20
        static let lineWidth: CGFloat = 3
        static let contentWidthScale: CGFloat = 0.7
        static let contentHeightScale: CGFloat = 0.3
    }
}


struct ContentView_Previews: PreviewProvider {
    static let game = RegularSetGame()
    static var previews: some View {
        RegularSetGameView(game: game)
    }
}
