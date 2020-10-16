//
//  ContextFree.swift
//  Chomsky_CYK
//
//  Created by Joao Batista on 16/10/20.
//  Copyright © 2020 Joao Batista. All rights reserved.
//

import Foundation
class ContextFree {
    var rules: [Rule]
    let alphabet: [String]
    var initialSymbol: LanguageElements
    init(alphabet: [String], rules: [Rule]) {
        self.alphabet = alphabet
        self.rules = rules
        self.initialSymbol = rules.first!.variable
    }
}
