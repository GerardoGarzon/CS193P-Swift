//
//  MemoryGame.swift
//  Programming_Assignment_2
//
//  Created by Gerardo Garzon on 09/07/22.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable{
    private(set) var cards: Array<Card>
    private(set) var title: String
    private(set) var color: String
    
    private var indexOfTheFaceUpCard: Int?
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { cardSelected in cardSelected.id == card.id }),
            !cards[chosenIndex].isFaceUp,
            !cards[chosenIndex].isMatched
        {
            if let potentialCard = indexOfTheFaceUpCard {
                if cards[chosenIndex].content == cards[potentialCard].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialCard].isMatched = true
                }
                indexOfTheFaceUpCard = nil
            } else {
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                indexOfTheFaceUpCard = chosenIndex
            }
            
            cards[chosenIndex].isFaceUp.toggle()
        }
    }
    
    mutating func newGame(numberOfPairsOfCards: Int, totalEmojis: Int, newTitle: String, newColor: String, newCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        let numberCards = (numberOfPairsOfCards > totalEmojis ? totalEmojis : numberOfPairsOfCards)
        for pairIndex in 0..<numberCards {
            let content: CardContent = newCardContent(pairIndex)
            
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: (pairIndex * 2) + 1))
        }
        cards.shuffle()
        title = newTitle
        color = newColor
    }
    
    init(numberOfPairsOfCards: Int, totalEmojis: Int, newTitle: String, newColor: String, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        let numberCards = (numberOfPairsOfCards > totalEmojis ? totalEmojis : numberOfPairsOfCards)
        for pairIndex in 0..<numberCards {
            let content: CardContent = createCardContent(pairIndex)
            
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: (pairIndex * 2) + 1))
        }
        cards.shuffle()
        title = newTitle
        color = newColor
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
        
    }
}
