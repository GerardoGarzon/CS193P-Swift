//
//  Memorize_MVVMApp.swift
//  Memorize_MVVM
//
//  Created by Gerardo Garzon on 06/07/22.
//

import SwiftUI

@main
struct Memorize_MVVMApp: App {
    let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
