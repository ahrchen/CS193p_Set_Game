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
        AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
            CardView(card: card)
                .padding(2)
        }
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
        .cardify()
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
