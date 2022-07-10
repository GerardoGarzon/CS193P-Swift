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
            Text(viewModel.title)
                .padding(.all)
                .font(.title)
                .foregroundColor(.primary)
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(viewModel.cards) { card in
                        CardView(card: card, color: viewModel.color)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                    }
                }
                .padding(.all)
            }
            .foregroundColor(viewModel.color)
            Spacer()
            Button(action: {
                viewModel.newGame()
            }, label: {
                Text("New Game")
            })
            .foregroundColor(.primary)
            .font(.title2)
            .padding(.all)
            
        }
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    let color: Color
    
    var body: some View {
        ZStack{
            let shapeCard = RoundedRectangle(cornerRadius: 8.0)
            if card.isFaceUp {
                shapeCard.fill().foregroundColor(Color.white)
                shapeCard.stroke(lineWidth: 3.0)
                    .foregroundColor(color)
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

