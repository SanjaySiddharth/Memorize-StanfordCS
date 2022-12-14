//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Sanjay Siddharth on 05/12/22.
//
//  ViewModel -intermediary between model and view

import SwiftUI

class EmojiMemoryGame: ObservableObject{
    typealias Card = MemoryGame<String>.Card
    private static let emojis = ["🚗","🏎️","🚙","🚒","🚜","🚠","🚄","🛺","🚑","🚀","✈️","🚲","🦼","🚛","🚁"]
    private static func createMemoryGame() -> MemoryGame<String>{
        MemoryGame(numberOfPairsOfCards: 6, createCardContent: {index in
                    EmojiMemoryGame.emojis[index]
            })
    }
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
        
    
    // privare -> only this ViewModel can see this model and do changes!
    // private(set) -> other classes can view this model but cant make changes
    
    var cards: Array<Card>{
        return model.cards
    }
    
    //MARK: Intents
    
    func choose(card:Card){
        model.choose(card)
    }
}
