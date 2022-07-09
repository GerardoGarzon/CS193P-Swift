//
//  ContentView.swift
//  Programming_Assignment_2
//
//  Created by Gerardo Garzon on 09/07/22.
//

import SwiftUI

struct ContentView: View {
    // The model will be the observed object to rebuild the View
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(viewModel.cards) { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card)
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
    let card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack{
            let shapeCard = RoundedRectangle(cornerRadius: 8.0)
            if card.isFaceUp {
                shapeCard.fill().foregroundColor(Color.white)
                shapeCard.stroke(lineWidth: 3.0).foregroundColor(Color.orange)
                Text(card.content).font(.largeTitle)
            } else if card.isMatched {
                shapeCard.opacity(0.0)
            } else {
                shapeCard.fill()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        
        ContentView(viewModel: game)
            .preferredColorScheme(.light)
    }
}

