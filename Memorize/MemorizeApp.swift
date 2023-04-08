//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Sanjay Siddharth on 28/11/22.
//

import SwiftUI

@main
struct MemorizeApp: App {
    @StateObject var themeStore = ThemeStore(name: "Default")
    let game = EmojiMemoryGame(theme: ThemeStore(name: "Default").themes[1] )

    var body: some Scene {
        WindowGroup {
            HomeScreen()
                .environmentObject(themeStore)
        }
    }
}
