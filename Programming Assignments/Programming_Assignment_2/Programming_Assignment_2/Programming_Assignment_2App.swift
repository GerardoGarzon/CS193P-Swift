//
//  Programming_Assignment_2App.swift
//  Programming_Assignment_2
//
//  Created by Gerardo Garzon on 09/07/22.
//

import SwiftUI

@main
struct Programming_Assignment_2App: App {
    let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
