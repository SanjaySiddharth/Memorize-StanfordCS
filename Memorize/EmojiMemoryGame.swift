//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Sanjay Siddharth on 05/12/22.
//
//  ViewModel -intermediary between model and view

import SwiftUI

class EmojiMemoryGame: ObservableObject{
    static let emojis = ["🚗","🏎️","🚙","🚒","🚜","🚠","🚄","🛺","🚑","🚀","✈️","🚲","🦼","🚛","🚁"]
    static func createMemoryGame() -> MemoryGame<String>{
        MemoryGame(numberOfPairsOfCards: 4, createCardContent: {index in
                    EmojiMemoryGame.emojis[index]
            })
    }
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
        
    
    // privare -> only this ViewModel can see this model and do changes!
    // private(set) -> other classes can view this model but cant make changes
    
    var cards: Array<MemoryGame<String>.Card>{
        return model.cards
    }
    
    //MARK: Intents
    
    func choose(card:MemoryGame<String>.Card){
        model.choose(card)
    }
}
