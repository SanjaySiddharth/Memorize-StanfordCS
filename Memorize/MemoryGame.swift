//
//  MemoryGame.swift
//  Memorize
//
//  Created by Sanjay Siddharth on 05/12/22.
//  Model - data source and the ultimate truth

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable{
    private(set) var cards: Array<Card>
    
    private var indexOfTheFaceUpCard: Int? {    //----> This is COMPUTED PROPERTY!!!    ---- because of this , no need to set value in the mutating function:CHOOSE()
        get{
            cards.indices.filter({cards[$0].isFaceUp}).oneAndOnly                      // cards.indices.filter({index in cards[index].isFaceUp})
        }                                                                               // filter means select the elements which meet the certain criteria
        set{
            cards.indices.forEach({cards[$0].isFaceUp = ($0 == newValue)  })           // {index in cards[index].isFaceUp = (index == newValue)}
        }                        //{cards[$0].isFaceUp = ($0 == newValue)}) ---> cards[index].isFaceUp == true if index == chosenvalue aka newValue
    }
    
    
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
                cards[chosenIndex].isFaceUp = true
            }
            else{
                indexOfTheFaceUpCard = chosenIndex        //----> this is the newValue in the setter property!
            }
        }
    }
        
    mutating func shuffle(){
        cards.shuffle()
    }
    init(numberOfPairsOfCards:Int,createCardContent: (Int)->CardContent){
        cards = []
        for pairIndex in 0..<numberOfPairsOfCards{
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content,id: pairIndex*2))
            cards.append(Card(content: content,id: pairIndex*2+1))
        }
        cards.shuffle()
    }
    struct Card: Identifiable{
        var isFaceUp: Bool=false{
            didSet{
                if isFaceUp {
                    startUsingBonusTime()
                }
                else{
                    stopUsingBonusTime()
                }
            }
        }
        var isMatched: Bool=false{
            didSet{
                stopUsingBonusTime()
            }
        }
        var content: CardContent        //CardContent is a dont-care element
        var id: Int
        
        //FOR BONUS TIME IMPLEMENTATION:
        var bonusTimeLimit : TimeInterval = 6
        private var faceUpTime : TimeInterval {
            if let lastFaceUpDate = self.lastFaceUpDate{
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            }
            else{
                return pastFaceUpTime
            }
        }
        var lastFaceUpDate : Date?
        var pastFaceUpTime : TimeInterval = 0
        var bonusTimeRemaining : TimeInterval{
            max(0,bonusTimeLimit - faceUpTime)
        }
        var bonusRemaining: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining/bonusTimeLimit : 0
        }
        var hasEarnedBonus : Bool {
            isMatched && bonusTimeRemaining > 0
        }
        var isConsumingBonusTime : Bool {
            isFaceUp && !isMatched && bonusTimeRemaining>0
        }
        private mutating func startUsingBonusTime(){
            if isConsumingBonusTime , lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        private mutating func stopUsingBonusTime(){
            pastFaceUpTime = faceUpTime
            lastFaceUpDate = nil
        }
        
    }


    }
    
    





extension Array{
    var oneAndOnly : Element? {
        return (self.count == 1 ? self.first : nil)      // Tenery operator for if-else
    }
}
