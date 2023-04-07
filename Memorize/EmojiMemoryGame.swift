//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Sanjay Siddharth on 05/12/22.
//
//  ViewModel -intermediary between model and view

import SwiftUI

class EmojiMemoryGame: ObservableObject{
    @Published private var model: MemoryGame<String>
    let chosenTheme : Theme 
    
    typealias Card = MemoryGame<String>.Card
//    private static let emojis = ["🚗","🏎️","🚙","🚒","🚜","🚠","🚄","🛺","🚑","🚀","✈️","🚲","🦼","🚛","🚁"]
    private static func createMemoryGame(of theme : Theme) -> MemoryGame<String>{
            let emojis = theme.emojis.map{String($0)}.shuffled()
        return MemoryGame(numberOfPairsOfCards: theme.emojis.count){
            index in
            emojis[index]
        }
    }
    init(theme: Theme) {
        chosenTheme = theme
        model = EmojiMemoryGame.createMemoryGame(of: chosenTheme)
    }
    
    // privare -> only this ViewModel can see this model and do changes!
    // private(set) -> other classes can view this model but cant make changes
    
    var cards: Array<Card>{
        return model.cards
    }
    
    //MARK: Intents
    
    func choose(card:Card){
        model.choose(card)
    }
    func shuffle(){
        model.shuffle()
    }
    func restart(){
        model = EmojiMemoryGame.createMemoryGame(of: chosenTheme)
    }
}
