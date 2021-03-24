//
//  Array+Only.swift
//  Memorize
//
//  Created by Allen Ding on 8/25/20.
//  Copyright © 2020 Allen Ding. All rights reserved.
//

import Foundation

extension Array {
    var only: Element? {
        self.count == 1 ? self.first : nil
    }
}
