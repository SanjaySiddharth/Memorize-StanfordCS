//
//  MemoryGame.swift
//  Memorize
//
//  Created by Sanjay Siddharth on 05/12/22.
//  Model - data source and the ultimate truth

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable{
    private(set) var cards: Array<Card>
    
    private var indexOfTheFaceUpCard: Int?
    
    
    mutating func choose(_ card: Card){
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}),
           !cards[chosenIndex].isFaceUp ,
           !cards[chosenIndex].isMatched
        {
            if let potentialMatchIndex = indexOfTheFaceUpCard{
                if cards[chosenIndex].content==cards[potentialMatchIndex].content{
                    cards[chosenIndex].isMatched=true
                    cards[potentialMatchIndex].isMatched=true
                }
                indexOfTheFaceUpCard=nil
            }
            else{
                for index in cards.indices{
                    cards[index].isFaceUp = false
                }
                indexOfTheFaceUpCard = chosenIndex
            }
            cards[chosenIndex].isFaceUp = true
        }
    }
        
    func index(of card:Card)->Int?{
        for index in 0..<cards.count{
            if(cards[index].id == card.id){
                return index
            }
        }
        return nil
    }
    init(numberOfPairsOfCards:Int,createCardContent: (Int)->CardContent){
        cards = Array<Card>()
        
        for pairIndex in 0..<numberOfPairsOfCards{
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content,id: pairIndex*2))
            cards.append(Card(content: content,id: pairIndex*2+1))
        }
    }
    struct Card: Identifiable{
        var isFaceUp: Bool=false
        var isMatched: Bool=false
        var content: CardContent        //CardContent is a dont-care element
        var id: Int

    }
    
}
