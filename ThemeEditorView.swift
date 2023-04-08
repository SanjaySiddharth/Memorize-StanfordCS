//
//  ThemeEditorView.swift
//  Memorize
//
//  Created by Sanjay Siddharth on 08/04/23.
//

import SwiftUI

struct ThemeEditorView: View {
    @EnvironmentObject var themeStore : ThemeStore
    var body: some View {
        Text(themeStore.themes[0].name)
    }
}

struct ThemeEditorView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeEditorView()
            .environmentObject(ThemeStore(name: "Default"))
    }
}
