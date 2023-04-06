//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Sanjay Siddharth on 28/11/22.
//

import SwiftUI

@main
struct MemorizeApp: App {
    let game = EmojiMemoryGame()
    @StateObject var themeStore = ThemeStore(name: "Default")
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
                .environmentObject(themeStore)
        }
    }
}
