//
//  SetApp.swift
//  Set
//
//  Created by Raymond Chen on 5/6/23.
//

import SwiftUI

@main
struct SetApp: App {
    private let game = RegularSetGame()
    
    var body: some Scene {
        WindowGroup {
            RegularSetGameView(game: game)
        }
    }
}
