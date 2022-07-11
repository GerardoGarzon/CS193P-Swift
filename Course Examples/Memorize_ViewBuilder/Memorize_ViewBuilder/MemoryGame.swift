//
//  MemoryGame.swift
//  Memorize_ViewBuilder
//
//  Created by Gerardo Garzon on 10/07/22.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable{
    private(set) var cards: Array<Card>
    
    private var indexOfTheFaceUpCard: Int?{
        get { cards.indices.filter( { index in cards[index].isFaceUp } ).oneAndOnly }
        //get { cards.firstIndex(where: {cardSelected in cardSelected.isFaceUp }) }
        set { cards.indices.forEach { index in cards[index].isFaceUp = (index == newValue) } }
    }
    
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
                cards[chosenIndex].isFaceUp = true
            } else {
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                indexOfTheFaceUpCard = chosenIndex
            }
        }
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = []
        for pairIndex in 0..<numberOfPairsOfCards {
            let content: CardContent = createCardContent(pairIndex)
            
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: (pairIndex * 2) + 1))
        }
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        var isFaceUp = true
        var isMatched = false
        let content: CardContent
        let id: Int
    }
}

extension Array {
    var oneAndOnly: Element? {
        if count == 1 {
            return first
        } else {
            return nil
        }
    }
}
