//
//  ThemeStore.swift
//  Memorize
//
//  Created by Sanjay Siddharth on 04/03/23.
//

import SwiftUI

//MARK: - MODEL
struct Theme : Codable , Identifiable , Hashable {
    var name :String
    var id:UUID
    var encodedColor:Int
    var emojis:[String]
    fileprivate init(name: String, id: UUID, encodedColor: Int, emojis: [String]) {
        self.name = name
        self.id = id
        self.encodedColor = encodedColor
        self.emojis = emojis
    }
    subscript(index : Int)->String{
        return self.emojis[index]
    }
}


//MARK: - VIEWMODEL
class ThemeStore : ObservableObject {
//    static let defaultThemes = [
//        Theme(name: "Vehicles", id: UUID(), encodedColor: 1, emojis: ["🚗","🏎️","🚙","🚒","🚜","🚠","🚄","🛺","🚑","🚀","✈️","🚲","🦼","🚛","🚁"]),
//        Theme(name: "Animals", id: UUID(), encodedColor: 2, emojis: ["🐶","🐱","🐭","🐹","🐰","🦊","🐻","🐼","🐻‍❄️"])]
    init(name : String) {
        self.name=name
        retrieveUserData()
        if themes.isEmpty {
            print("Using in-built themes")
            insertTheme(name: "Animals", color: 2, emojis: ["🐶","🐱","🐭","🐹","🐰","🦊","🐻","🐼","🐻‍❄️"])
            insertTheme(name: "Vehicles", color: 1, emojis: ["🚗","🏎️","🚙","🚒","🚜","🚠","🚄","🛺","🚑","🚀","✈️","🚲","🦼","🚛","🚁"])
        }
        else{
            print("Successfully loaded palettes from User Data and theme store : \(name)")
        }
    }
    let name : String
    @Published var themes = [Theme](){
        didSet{
            storeUserData()
        }
    }
  //MARK: - Intents
    private var userDefaultsKey : String {
        "ThemeStore:"+name
    }
    private func storeUserData() {
        UserDefaults.standard.set(try? JSONEncoder().encode(themes), forKey: userDefaultsKey)
    }
    private func retrieveUserData(){
        if let jsonData = UserDefaults.standard.data(forKey: userDefaultsKey),
           let decodedThemes = try? JSONDecoder().decode([Theme].self, from: jsonData){
            themes = decodedThemes
        }
    }
    func insertTheme(name:String,color:Int,emojis:[String]){
        let newTheme : Theme = Theme(name: name, id: UUID(), encodedColor: color , emojis: emojis)
        themes.insert(newTheme, at: themes.count)
    }
    func returnInitialTheme()->Theme{
        return themes[0]
    }
   
    
    
}
