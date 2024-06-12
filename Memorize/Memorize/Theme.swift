//
//  Theme.swift
//  Memorize
//
//  Created by Алексей Зубель on 26.05.24.
//

import Foundation

struct Theme{
    let name: String
    let emojis: Array<String>
    var numberOfPairs: Int
    let color: String
    
    init(name: String, emojis: Array<String>, color: String) {
        self.name = name
        self.emojis = emojis
        self.numberOfPairs = emojis.count
        self.color = color
    }
}
