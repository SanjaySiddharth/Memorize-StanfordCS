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
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
