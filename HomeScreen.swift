//
//  HomeScreen.swift
//  Memorize
//
//  Created by Sanjay Siddharth on 29/03/23.
//

import SwiftUI

struct HomeScreen: View {
    @EnvironmentObject var themeStore : ThemeStore
    var body: some View {
        NavigationView{
            List(themeStore.themes){theme in
                NavigationLink(theme.name, destination: EmojiMemoryGameView(game: EmojiMemoryGame(theme: theme)))
            }
            
            
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
            .environmentObject(ThemeStore(name: "Default"))
    }
}
