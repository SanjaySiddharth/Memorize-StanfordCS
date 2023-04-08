//
//  HomeScreen.swift
//  Memorize
//
//  Created by Sanjay Siddharth on 29/03/23.
//

import SwiftUI

struct HomeScreen: View {
    @EnvironmentObject var themeStore : ThemeStore
    @State private var editMode : EditMode = .inactive
    var body: some View {
        NavigationStack{
            List(){
                ForEach(themeStore.themes){
                    theme in
                    NavigationLink(destination: EmojiMemoryGameView(game: EmojiMemoryGame(theme: theme))){
                        HStack(){
                            Text(theme.name)
                        }
                    }
                }
                .onDelete(perform: {
                    indexSet in
                    themeStore.themes.remove(atOffsets: indexSet)
                })
                .onMove(perform: {
                    indexSet,newOffset in
                    themeStore.themes.move(fromOffsets: indexSet, toOffset: newOffset)
                })
                
            }
            .navigationTitle("Select Theme")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                EditButton()
            }
            .environment(\.editMode, $editMode)
        }
        
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
            .environmentObject(ThemeStore(name: "Default"))
    }
}
