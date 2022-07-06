//
//  ContentView.swift
//  Memorize_Example
//
//  Created by Gerardo Garzon on 06/07/22.
//

import SwiftUI

struct ContentView: View {
    @State var emojis = ["⌚️", "📱", "📲", "💻", "⌨️", "🖥", "🖨", "🖱", "🖲", "🕹", "🗜", "💽", "💾", "💿", "📀", "📼", "📷", "📸", "📹", "🎥", "📽", "🎞", "📞", "☎️", "📟", "📠", "📺", "📻", "🎙", "🎚", "🎛", "🧭"]
    @State var emojiCount = 6
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(emojis[0 ..< emojiCount], id: \.self, content: { emoji in
                        CardView(content: emoji)
                            .aspectRatio(2/3, contentMode: .fit)
                    })
                }
                .padding(.all)
            }
            Spacer()
            HStack {
                remove
                Spacer()
                shuffle
                Spacer()
                add
            }
            .padding(.all)
            .font(.title2)
            .foregroundColor(Color.primary)
        }
    }
    
    var remove: some View {
        Button(action: {
            if emojiCount > 1 {
                emojiCount -= 1
            }
        }, label: {
            Image(systemName: "minus.circle")
        })
        .padding(.leading)
    }
    
    var add: some View {
        Button(action: {
            if emojiCount < emojis.count {
                emojiCount += 1
            }
        }, label: {
            Image(systemName: "plus.circle")
        })
        .padding(.trailing)
    }
    
    var shuffle: some View {
        Button(action: {
            emojis.shuffle()
        }, label: {
            Text("SHUFFLE")
        })
    }
}

struct CardView: View {
    @State var isFaceUp: Bool = false
    var content: String
    
    var body: some View {
        ZStack{
            let shapeCard = RoundedRectangle(cornerRadius: 8.0)
            if isFaceUp {
                shapeCard.fill().foregroundColor(Color.white)
                shapeCard.stroke(lineWidth: 3.0).foregroundColor(Color.orange)
                Text(content).font(.largeTitle)
            } else {
                shapeCard.fill().foregroundColor(Color.orange)
            }
        }
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}

