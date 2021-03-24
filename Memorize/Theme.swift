//
//  Theme.swift
//  Memorize
//
//  Created by Allen Ding on 8/25/20.
//  Copyright © 2020 Allen Ding. All rights reserved.
//

import SwiftUI

struct Theme: Hashable{
    let name: String
    let emojis: [String]
    let numberOfPairsOfCards: Int?
    let color: Color
}
