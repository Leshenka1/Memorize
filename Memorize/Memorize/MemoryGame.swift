//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Алексей Зубель on 22.05.24.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable{
    private(set) var cards: Array<Card>
    private(set) var themeName: String
    private(set) var themeColor: String
    private(set) var score: Int = 0
    
    init(numberOfPairsOfCards: Int, themeName: String, themeColor: String, cardContentFactory: (Int) -> CardContent){
        cards = Array<Card>()
        self.themeName = themeName
        self.themeColor = themeColor
        for pairIndex in 0..<max(2, numberOfPairsOfCards){
            let cardContent = cardContentFactory(pairIndex)
            cards.append(Card(content: cardContent, id: "\(pairIndex + 1)a"))
            cards.append(Card(content: cardContent, id: "\(pairIndex + 1)b"))
        }
        cards.shuffle()     //shuffle cards in the first game
    }
    
    var previousChosenCardIndex: Int?{
        get {
            var faceUpCardIndices = [Int]()
            for index in cards.indices {
                if (cards[index].isFaceUp && !cards[index].isMatched) {
                    faceUpCardIndices.append(index)
                }
            }
            if (faceUpCardIndices.count == 1) {
                return faceUpCardIndices.first
            }
            else {
                return nil
            }
        }
        set {
            for index in cards.indices {
                if (index == newValue){
                    cards[index].isFaceUp = true
                } else{
                    if(cards[index].isMatched != true){
                        cards[index].isFaceUp = false
                    }
                }
            }
        }
    }
    
    mutating func choose(_ card: Card){
        for chosenIndex in cards.indices where card.id == cards[chosenIndex].id {
            if(!cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched){
                if let potentialMatchCardIndex = previousChosenCardIndex{
                    if(cards[chosenIndex].content == cards[potentialMatchCardIndex].content){
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchCardIndex].isMatched = true
                        score = score + 2
                    }
                    else{
                        if (cards[chosenIndex].isChosen || cards[potentialMatchCardIndex].isChosen){
                            score = score - 1
                        }
                        cards[chosenIndex].isChosen = true
                        cards[potentialMatchCardIndex].isChosen = true
                    }
                }else{
                    previousChosenCardIndex = chosenIndex
                }
                cards[chosenIndex].isFaceUp = true
            }
        }
    }
    
    mutating func shuffle(){
        cards.shuffle()
    }
    
    struct Card: Equatable, Identifiable{
        var isFaceUp = false
        var isMatched = false
        var isChosen = false
        let content: CardContent
        var id: String
    }
    
    
    
}
