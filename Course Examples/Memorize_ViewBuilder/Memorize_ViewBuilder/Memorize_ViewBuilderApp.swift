//
//  Memorize_ViewBuilderApp.swift
//  Memorize_ViewBuilder
//
//  Created by Gerardo Garzon on 10/07/22.
//

import SwiftUI

@main
struct Memorize_MVVMApp: App {
    private let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(gameViewModel: game)
        }
    }
}
