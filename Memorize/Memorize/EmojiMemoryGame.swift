//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Алексей Зубель on 22.05.24.
//

import SwiftUI



class EmojiMemoryGame: ObservableObject{
    
    private static let themes: Array<Theme> = [
        Theme(name: "Balls", emojis: ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐"], color: "red"),
        Theme(name: "Cars", emojis: ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎️", "🚓", "🚑", "🚒", "🚐", "🛻", "🚚"], color: "gray"),
        Theme(name: "Animals", emojis: ["🐹", "🐰", "🦊", "🐻", "🐼", "🦁", "🐵"], color: "blue"),
        Theme(name: "Fruits", emojis: ["🍎", "🌶️", "🫒", "🍓", "🍋", "🥝", "🍉", "🍍"], color: "green"),
        Theme(name: "Bugs", emojis: ["🐝", "🪱", "🐛", "🐜", "🐞", "🐌", "🪳"], color: "orange"),
        Theme(name: "Smiles", emojis: ["😀", "😇", "😂", "😙", "😎", "😍", "😤", "😳"], color: "yellow")
    ]
    
    @Published private var model = createMemoryGame()
    
//    var randomTheme: Theme{
//        return themes.randomElement() ?? Theme(name: "Shit", emojis: ["💩"], color: "brown")
//    }
    
    var themeName: String{
        return model.themeName
    }
    
    private static func createMemoryGame() -> MemoryGame<String>{
        if let randomTheme = themes.randomElement(){
        let emojis = randomTheme.emojis
            return MemoryGame(numberOfPairsOfCards:
                                Int.random(in: 2...randomTheme.numberOfPairs),  //MARK: Extra credit 2
                              themeName: randomTheme.name, themeColor: randomTheme.color) 
            {pairIndex in
                if (emojis.indices.contains(pairIndex)){
                    return emojis[pairIndex]
                }else{
                    return "💩"             //MARK: Extra credit 1
                }
            }
        }
        else{
            return MemoryGame(numberOfPairsOfCards: 2, themeName: "Shit", themeColor: "brown") {pairIndex in
                return "💩"
            }
        }
    }
    
    var cards: Array<MemoryGame<String>.Card>{
        return model.cards
    }
    
    func newGame(){
        model = EmojiMemoryGame.createMemoryGame()
        model.shuffle()
    }
    
    func choose(card: MemoryGame<String>.Card){
        model.choose(card)
    }
    
    var gameScore: String{
        return String(model.score)
    }
    
    //MARK: Extra credit 3
    var themeColors: Array<Color>{
        switch model.themeColor{
        case "red":
            return [Color.red, Color.red.opacity(0.3)]
        case "gray":
            return [Color.gray, Color.gray.opacity(0.3)]
        case "blue":
            return [Color.blue, Color.blue.opacity(0.3)]
        case "green":
            return [Color.green, Color.green.opacity(0.3)]
        case "orange":
            return [Color.orange, Color.orange.opacity(0.3)]
        case "yellow":
            return [Color.yellow, Color.yellow.opacity(0.3)]
        default:
            return [Color.brown, Color.brown.opacity(0.3)]
        }
    }
    
}
