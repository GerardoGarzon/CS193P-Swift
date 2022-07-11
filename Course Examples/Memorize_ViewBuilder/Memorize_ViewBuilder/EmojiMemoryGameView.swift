//
//  ContentView.swift
//  Memorize_ViewBuilder
//
//  Created by Gerardo Garzon on 10/07/22.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    // The model will be the observed object to rebuild the View
    @ObservedObject var gameViewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(gameViewModel.cards) { card in
                        CardView(card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                gameViewModel.choose(card)
                            }
                    }
                }
                .padding(.all)
            }
            .foregroundColor(Color.orange)
            .padding(.all)
        }
    }
}

struct CardView: View {
    private let card: EmojiMemoryGame.Card
    
    init(_ card: EmojiMemoryGame.Card) {
        self.card = card
    }
    
    var body: some View {
        GeometryReader(content: { geometry in
            ZStack{
                let shapeCard = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                if card.isFaceUp {
                    shapeCard.fill().foregroundColor(Color.white)
                    shapeCard.stroke(lineWidth: DrawingConstants.lineWidth).foregroundColor(Color.orange)
                    Text(card.content).font(font(in: geometry.size))
                } else if card.isMatched {
                    shapeCard.opacity(0.0)
                } else {
                    shapeCard.fill()
                }
            }
        })
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 8.0
        static let lineWidth: CGFloat = 3.0
        static let fontScale: CGFloat = 0.7
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        
        EmojiMemoryGameView(gameViewModel: game)
            .preferredColorScheme(.light)
    }
}
