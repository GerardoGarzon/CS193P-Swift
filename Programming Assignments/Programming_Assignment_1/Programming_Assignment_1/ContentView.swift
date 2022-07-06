//
//  ContentView.swift
//  Programming_Assignment_1
//
//  Created by Gerardo Garzon on 06/07/22.
//

import SwiftUI

struct ContentView: View {
    var carsEmojis = ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑", "🚒", "🚐", "🛻", "🚚", "🚛", "🚜"]
    var faceEmojis = ["😀", "😍", "🥸", "😠", "😏", "😡", "😨", "🥳", "😛", "🥹", "😞", "🥶", "🥵", "😇"]
    var petsEmojis = ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐻‍❄️", "🐨", "🐯", "🦁", "🐮", "🐷"]

    @State var emojisShowed = ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑", "🚒", "🚐", "🛻", "🚚", "🚛", "🚜"]
    
    @State var emojiCount = 14
    
    var body: some View {
        VStack {
            Text("Memorize Game")
                .padding()
                .font(.title2)
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(emojisShowed[0 ..< emojiCount], id: \.self, content: { emoji in
                        CardView(content: emoji)
                            .aspectRatio(2/3, contentMode: .fit)
                    })
                }
                .padding(.all)
            }
            Spacer()
            LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]){
                carsButton
                faceButton
                petsButton
            }
        }
    }
    
    var carsButton: some View {
        VStack {
            Button(action: {
                emojisShowed = carsEmojis.shuffled()
                emojiCount = Int.random(in: 4...emojisShowed.count)
            }, label: {
                Label("Cars", systemImage: "car.fill")
                    .labelStyle(VerticalLabelStyle())
            })
            .foregroundColor(.primary)
        }
    }
    
    var faceButton: some View {
        VStack {
            Button(action: {
                emojisShowed = faceEmojis.shuffled()
                emojiCount = Int.random(in: 4...emojisShowed.count)
            }, label: {
                Label("Emojis", systemImage: "face.smiling.fill")
                    .labelStyle(VerticalLabelStyle())
            })
            .foregroundColor(.primary)
        }
    }
    
    var petsButton: some View {
        VStack {
            Button(action: {
                emojisShowed = petsEmojis.shuffled()
                emojiCount = Int.random(in: 4...emojisShowed.count)
            }, label: {
                Label("Animals", systemImage: "pawprint.fill")
                    .labelStyle(VerticalLabelStyle())
            })
            .foregroundColor(.primary)
        }
    }
    
    
}

struct VerticalLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack {
            configuration.icon
                .font(.title)
            configuration.title
        }
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
            .previewInterfaceOrientation(.portrait)
    }
}
