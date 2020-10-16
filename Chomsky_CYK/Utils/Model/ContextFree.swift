//
//  ContextFree.swift
//  Chomsky_CYK
//
//  Created by Joao Batista on 16/10/20.
//  Copyright © 2020 Joao Batista. All rights reserved.
//

import Foundation
class ContextFree {
    let rules: [Rule]
    let alphabet: [String]

    init(alphabet: [String], rules: [Rule]) {
        self.alphabet = alphabet
        self.rules = rules
    }
}
