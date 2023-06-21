//
//  ContentView.swift
//  Set
//
//  Created by Raymond Chen on 5/6/23.
//

import SwiftUI

struct RegularSetGameView: View {
    
    @ObservedObject var game: RegularSetGame
    
    @Namespace private var discardingNamespace
    @Namespace private var dealingNamespace
    
    var body: some View {
        PlayerView(game: game, player: 1)
        Divider()
        gameBody
        HStack {
            deckBody
            Spacer()
            discardBody
                
        }
        .onAppear(perform: game.newGame)
        Divider()
        PlayerView(game: game, player: 2)
        controlsBody
        .padding(5)
    }
        
    
    var controlsBody: some View {
        HStack {
            Button("New Game") {
                game.newGame()
            }
            Spacer()
            Button("Cheat") {
                game.cheat()
                game.refresh()
            }
        }
    }
    
    var gameBody: some View {
        AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
            CardView(card: card)
                .padding(2)
                .matchedGeometryEffect(id: card.id, in: discardingNamespace)
                .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                .transition(AnyTransition.asymmetric(insertion: .identity, removal: .identity))
                .zIndex(zIndex(of: card))
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        game.choose(card)
                    }
                    if game.cards.contains(where: {card in
                        card.isMatched
                    }) {
                        withAnimation(.easeInOut(duration: CardConstants.dealDuration).delay(0.5)) {
                            game.addThreeCards()
                        }
                        withAnimation(.easeInOut(duration: CardConstants.dealDuration)) {
                            game.refresh()
                        }
                    }
                }
        }
        .animation(.easeInOut(duration: CardConstants.dealDuration), value: game.discardPile)
        
    }
    
    // Deck body
    var deckBody: some View {
        ZStack {
            ForEach(game.deck) { card in
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(AnyTransition.asymmetric(insertion: .identity, removal: .identity))
                    .offset(x: CGFloat(Double(card.id) * 0.25), y: CGFloat(Double(card.id) * 0.25))
            }
        }
        .frame(width: CardConstants.undealtWidth, height: CardConstants.undealtHeight)
        .foregroundColor(CardConstants.color)
        .onTapGesture {
            withAnimation(.easeInOut(duration: CardConstants.dealDuration)){
                game.dealThreeCards()
            }
        }
        .disabled(game.deck.isEmpty)
        .padding(15)
    }
    
    private func zIndex(of card: RegularSetGame.Card) -> Double {
        -Double(game.deck.firstIndex(where: { $0.id == card.id }) ?? 0)
    }
    
    // Discard body
    var discardBody: some View {
        ZStack {
            ForEach(game.discardPile) { card in
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: discardingNamespace)
                    .transition(AnyTransition.asymmetric(insertion: .identity, removal: .identity))
                    .offset(x: CGFloat(Double(card.id) * 0.15), y: CGFloat(Double(card.id) * 0.15))
                }
        }
        .frame(width: CardConstants.undealtWidth, height: CardConstants.undealtHeight)
        .animation(.easeInOut(duration: 1), value: game.discardPile)
        .padding(15)
    }
    
    private struct CardConstants {
        static let aspectRatio: CGFloat = 2/3
        static let undealtWidth = undealtHeight * aspectRatio
        static let undealtHeight: CGFloat = 90
        static let color = Color.purple
        static let dealDuration: Double = 1
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
