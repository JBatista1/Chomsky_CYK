//
//  Exemples.swift
//  Chomsky_CYK
//
//  Created by Joao Batista on 16/10/20.
//  Copyright © 2020 Joao Batista. All rights reserved.
//

import Foundation

class Exemples {
    static func getExempleOne() -> ContextFree {
        let elementF = LanguageElements("F", .variable)
        let elementO = LanguageElements("O", .variable)
        let elementA = LanguageElements("A", .variable)
        let elementN = LanguageElements("N", .variable)
        let elementArrow = LanguageElements("->", .alphabet)
        let elementIntersection = LanguageElements("/\\", .alphabet)
        let elementUnion = LanguageElements("\\/", .alphabet)
        let elementDenial = LanguageElements("!", .alphabet)
        let elementOpenParentheses = LanguageElements("(", .alphabet)
        let elementCloseParentheses = LanguageElements(")", .alphabet)
        let elementp = LanguageElements("p", .alphabet)
        let elementq = LanguageElements("q", .alphabet)
        let elementr = LanguageElements("r", .alphabet)

        let ruleOne = Rule(variable: elementF, rules: [[elementO, elementArrow, elementF], [elementO]])
        let ruleTwo = Rule(variable: elementO, rules: [[elementO, elementUnion, elementA], [elementA]])
        let ruleThree = Rule(variable: elementA, rules: [[elementA, elementIntersection, elementN], [elementN]])
        let ruleFour = Rule(variable: elementN, rules: [[elementDenial, elementN],
                                                        [elementOpenParentheses, elementF, elementCloseParentheses],
                                                        [elementp],
                                                        [elementq],
                                                        [elementr]])

        let rules = [ruleOne, ruleTwo, ruleThree, ruleFour]
        let contextFree =  ContextFree(alphabet: ["->", "/\\", "\\/", "!", "(", ")", "p", "q", "r"], rules: rules)
        return contextFree
    }
}
