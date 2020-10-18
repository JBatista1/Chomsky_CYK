//
//  Rule.swift
//  Chomsky_CYK
//
//  Created by Joao Batista on 16/10/20.
//  Copyright © 2020 Joao Batista. All rights reserved.
//

import Foundation

struct Rule {
    var variable: LanguageElements
    var rules: [[LanguageElements]]
}
extension Rule: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(Rule.self).hashValue)
    }
    static func == (lhs: Rule, rhs: Rule) -> Bool {
        return lhs.variable == rhs.variable && lhs.rules == rhs.rules
    }
}
