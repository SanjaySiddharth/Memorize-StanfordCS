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
        AspectVGrid(items: game.cards, aspectRatio: 2/3, content: {
            card in
            cardView(for: card)
        })
        .padding(.horizontal)
        .foregroundColor(.red)
    }
    @ViewBuilder
    private func cardView(for card: EmojiMemoryGame.Card) -> some View {
        if card.isMatched && !card.isFaceUp {
            Rectangle().opacity(0)
        }
        else{
            CardView(card: card)
                .padding(4)
                .onTapGesture {
                    game.choose(card: card)
                }
            
        }
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
                    Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 120-90))
                        .opacity(0.5)
                        .padding(5)
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
        static let cornerRadius: CGFloat = 10
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
