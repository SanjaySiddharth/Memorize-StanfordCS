//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Sanjay Siddharth on 28/11/22.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame
    var body: some View {
        
        ScrollView{
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 86))]){
                ForEach(game.cards){card in
                    CardView(card: card)
                        .aspectRatio(2/3 , contentMode: .fit)
                        .onTapGesture {
                            game.choose(card: card)
                        }
                }
            }
            .foregroundColor(.pink)
        }
    .padding(.horizontal)
    }
}


struct CardView: View{
    let card: EmojiMemoryGame.Card
    
    var body: some View{
        GeometryReader(content: {geometry in
            ZStack{
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)

                if card.isFaceUp{
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth:DrawingConstants.lineWidth)
                    Text(card.content).font(.system(size: min(geometry.size.width, geometry.size.height)*DrawingConstants.fontScale))
                }
                else if card.isMatched{
                    shape.opacity(0.0)
                }
                else{
                    shape.fill()
                }
            }
        })
    }
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 20
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.7
    }
}


struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        EmojiMemoryGameView(game:game)
    }
}
