//
//  EmojiMemoryGame.swift
//  Programming_Assignment_2
//
//  Created by Gerardo Garzon on 09/07/22.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    static var randomIndex: Int = 1
    
    // Published will send that the object will change
    @Published private var model: MemoryGame<String> = createMemoryGame()
    
    // Available emojis themes
    static let themes = [["😀", "🥰", "🥹", "😂", "🥲", "😇", "😛", "😡", "🥵", "🥸", "🤬", "🤮", "🤢", "😵"],
                         ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐻‍❄️", "🐨", "🐯", "🦁", "🐮", "🐷"],
                         ["🥐", "🥯", "🍞", "🌮", "🥨", "🧀", "🍳", "🍕", "🥞", "🍔", "🌭", "🥩", "🍗", "🍖"],
                         ["🇲🇽", "🇯🇵", "🇨🇦", "🇰🇷", "🇰🇵", "🇺🇸", "🇪🇸", "🇦🇷", "🇶🇦", "🇮🇹", "🇺🇦", "🇸🇪", "🇬🇧", "🇧🇷"],
                         ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑", "🚒", "🚐", "🛻", "🚚", "🚛", "🚜"],
                         ["📆", "🗑", "🗄", "📋", "📈", "📉", "📰", "📐", "🖇", "📌", "🔎", "✂️", "🖊", "🖍"]
    ]
    
    // Available colors to display the themes
    static let colorsAvailable = ["blue", "brown", "cyan", "gray", "green", "indigo", "orange", "purple", "red", "yellow"]
    static let swiftUIColors = [Color.blue, Color.brown, Color.cyan, Color.gray, Color.green, Color.indigo, Color.orange, Color.purple, Color.red, Color.yellow]
    
    // Titles for the themes
    static let titlesThemes = [
        "Faces memorize",
        "Animals memorize",
        "Food memorize",
        "Countries memorize",
        "Vehicles memorize",
        "Office memorize"
    ]
    
    static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 10,
                           totalEmojis: themes[randomIndex].count,
                           newTitle: EmojiMemoryGame.titlesThemes[randomIndex],
                           newColor: EmojiMemoryGame.colorsAvailable.randomElement()!,
                           createCardContent: { index in
            themes[randomIndex][index]
        } )
    }
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    var title: String {
        model.title
    }
    
    var color: Color {
        let indexOfColor = EmojiMemoryGame.colorsAvailable.firstIndex(where: {value in value == model.color})!
        return EmojiMemoryGame.swiftUIColors[indexOfColor]
    }
    
    // Choose a random theme to start the game
    init() {
        // EmojiMemoryGame.randomIndex = Int.random(in: EmojiMemoryGame.titlesThemes.indices)
        EmojiMemoryGame.randomIndex = 1
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func newGame() {
        let actualIndex = EmojiMemoryGame.randomIndex
        EmojiMemoryGame.randomIndex = Int.random(in: EmojiMemoryGame.titlesThemes.indices)
        while actualIndex == EmojiMemoryGame.randomIndex {
            EmojiMemoryGame.randomIndex = Int.random(in: EmojiMemoryGame.titlesThemes.indices)
        }
        
        model.newGame(numberOfPairsOfCards: 10,
                      totalEmojis: EmojiMemoryGame.themes[EmojiMemoryGame.randomIndex].count,
                      newTitle: EmojiMemoryGame.titlesThemes[EmojiMemoryGame.randomIndex],
                      newColor: EmojiMemoryGame.colorsAvailable.randomElement()!,
                      newCardContent: { index in
            EmojiMemoryGame.themes[EmojiMemoryGame.randomIndex][index]
        } )
    }

}
