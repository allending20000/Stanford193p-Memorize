//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Allen Ding on 8/20/20.
//  Copyright Β© 2020 Allen Ding. All rights reserved.
//

import SwiftUI


class EmojiMemoryGame: ObservableObject {
    
    @Published private var game: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    static let halloweenTheme = Theme(name: "Halloween", emojis: ["π»", "π", "π·", "β οΈ", "π¦"], numberOfPairsOfCards: nil, color: Color.orange)
    static let foodTheme = Theme(name: "Food", emojis: ["π", "π­", "π"], numberOfPairsOfCards: 3, color: Color.yellow)
    static let animalTheme = Theme(name: "Animal", emojis: ["π¦", "π", "π¦", "π¦"], numberOfPairsOfCards: 4, color: Color.green)
    static let flagTheme = Theme(name: "Flag", emojis: ["π¨π³", "πΊπΈ", "π¨π¦", "π¦πΊ", "πΉπ©"], numberOfPairsOfCards: 5, color: Color.blue)
    static let sportsTheme = Theme(name: "Sport", emojis: ["π", "π", "πΎ"], numberOfPairsOfCards: 3, color: Color.red)
    static let weatherTheme = Theme(name: "Weather", emojis: ["π§", "π©"], numberOfPairsOfCards: 2, color: Color.black)
    static let possibleThemes = [halloweenTheme, foodTheme, animalTheme, flagTheme, sportsTheme, weatherTheme]
    static var chosenTheme = weatherTheme
    
    // MARK: - Access to the Model
    var cards: Array<MemoryGame<String>.Card> {
        game.cards
    }
    
    var points: Int {
        game.points
    }
    
    // MARK: - Intent(s)
    
    func choose(card: MemoryGame<String>.Card) {
        game.choose(card: card)
    }
    
    private static func createMemoryGame() -> MemoryGame<String> {
        let emojis = chosenTheme.emojis
        let numberOfPairsOfCards = chosenTheme.numberOfPairsOfCards != nil ? chosenTheme.numberOfPairsOfCards! : Int.random(in: 2...5)
        return MemoryGame<String>(numberOfPairsOfCards: numberOfPairsOfCards) {pairIndex in emojis[pairIndex]}
    }
    
    func createNewMemoryGameWithRandomTheme() {
        EmojiMemoryGame.chosenTheme = EmojiMemoryGame.possibleThemes[Int.random(in: 0...5)]
        game = EmojiMemoryGame.createMemoryGame()
    }
}
