//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Sanjay Siddharth on 28/11/22.
//View

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame
    @Namespace private var dealingNamespace
    var body: some View {
        ZStack(alignment: .bottom){
                VStack{
                gameBody
                
                HStack{
                    restart
                    Spacer()
                    shuffle
                }
                .padding(.horizontal)
            }
            deckBody
                
            }
        .padding(.horizontal)
        }
    //some Variables and functions for dealing cards:
    @State private var dealt = Set<Int>()
    private func deal(_ card : EmojiMemoryGame.Card){
        dealt.insert(card.id)
    }
    private func isUndealt(_ card : EmojiMemoryGame.Card) -> Bool {
        !dealt.contains(card.id)
    }
    private func dealAnimation(for card: EmojiMemoryGame.Card) -> Animation {
        var delay = 0.0
        if let index = game.cards.firstIndex(where: {$0.id == card.id}){
            delay = Double(index) * (CardConstants.totalDealDuration / Double(game.cards.count))
        }
        return Animation.easeInOut(duration: CardConstants.dealDuration).delay(delay)
    }
    
    private func zIndex(of card: EmojiMemoryGame.Card) -> Double{
        -Double(game.cards.firstIndex(where: {$0.id == card.id}) ?? 0 )
        
    }
    var gameBody: some View{
        AspectVGrid(items: game.cards, aspectRatio: 2/3) {
            card in
            if isUndealt(card)||(card.isMatched && !card.isFaceUp){
                Color.clear
            }
            else{
                CardView(card: card)
                    .padding(4)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(AnyTransition.asymmetric(insertion: .identity, removal: .scale))
                    .zIndex(zIndex(of: card))
                    .onTapGesture {
                        withAnimation{
                            game.choose(card: card)
                        }
                    }
            }
        }
                .foregroundColor(CardConstants.color)
        
    }
    var deckBody : some View{
        ZStack{
            ForEach(game.cards.filter(isUndealt)){card in
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(AnyTransition.asymmetric(insertion: .opacity, removal: .identity)
                    
                            )
                        }
        }
        .frame(width: CardConstants.unDealtWidth,height: CardConstants.unDealtHeight)
        .foregroundColor(CardConstants.color)
        .onTapGesture{
            //deal the cards
            for card in game.cards{
                withAnimation(dealAnimation(for: card)){
                    deal(card)
                }
            }
        }

    }
    var shuffle : some View{
        Button("Shuffle"){
            withAnimation{
                game.shuffle()
            }
        }
    }
    var restart : some View{
        Button("Restart"){
            withAnimation{
                dealt=[]
                game.restart()
            }
        }
    }
    private struct CardConstants{
        static let color = Color.red
        static let aspectRatio : CGFloat = 2/3
        static let dealDuration : Double = 0.5
        static let totalDealDuration: Double = 2
        static let unDealtHeight : CGFloat = 90
        static let unDealtWidth = unDealtHeight * aspectRatio
    }
    }


struct CardView: View{
    let card: EmojiMemoryGame.Card
    @State private var animatedBonusRemaining : Double = 0
    var body: some View{
        GeometryReader(content: {geometry in
            ZStack{
                Group{
                    if card.isConsumingBonusTime{
                        Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: (animatedBonusRemaining)*360-90))
                            .onAppear{
                                animatedBonusRemaining = card.bonusRemaining
                                withAnimation(.linear(duration: card.bonusTimeRemaining)){
                                    animatedBonusRemaining=0
                                }
                            }
                    }
                    else{
                        Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: (card.bonusRemaining)*360-90))
                    }
                }
                        .opacity(0.5)
                        .padding(5)
                
                Text(card.content)
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
                    .font(Font.system(size: DrawingConstants.fontSize))
                    .scaleEffect(scale(thatFits: geometry.size))
            }
            .cardify(isFaceUp: card.isFaceUp)
            
        }
        )}
        
    }
private func scale (thatFits size : CGSize)->CGFloat{
    min(size.width, size.height) / (DrawingConstants.fontSize / DrawingConstants.fontScale)
}
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.7
        static let fontSize : CGFloat = 32
    }



struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        
        let game = EmojiMemoryGame(theme: ThemeStore(name: "Default").themes[0])
        EmojiMemoryGameView(game:game)
    }
}
