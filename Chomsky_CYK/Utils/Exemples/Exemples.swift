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
        let elementF = LanguageElements(name: "F", type: .variable)
        let elementO = LanguageElements(name: "O", type: .variable)
        let elementA = LanguageElements(name: "A", type: .variable)
        let elementN = LanguageElements(name: "N", type: .variable)
        let elementArrow = LanguageElements(name: "->", type: .alphabet)
        let elementIntersection = LanguageElements(name: "/\\", type: .alphabet)
        let elementUnion = LanguageElements(name: "\\/", type: .alphabet)
        let elementDenial = LanguageElements(name: "!", type: .alphabet)
        let elementOpenParentheses = LanguageElements(name: "(", type: .alphabet)
        let elementCloseParentheses = LanguageElements(name: ")", type: .alphabet)
        let elementp = LanguageElements(name: "p", type: .alphabet)
        let elementq = LanguageElements(name: "q", type: .alphabet)
        let elementr = LanguageElements(name: "r", type: .alphabet)

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
    static func getExempleTwo() -> ContextFree {
        let elementS = LanguageElements(name: "S", type: .variable)
        let elementA = LanguageElements(name: "A", type: .variable)
        let elementB = LanguageElements(name: "B", type: .variable)
        let elementC = LanguageElements(name: "C", type: .variable)
        let elementa = LanguageElements(name: "a", type: .alphabet)
        let elementb = LanguageElements(name: "b", type: .alphabet)
        let elementab = LanguageElements(name: "ab", type: .alphabet)

        let ruleOne = Rule(variable: elementS, rules: [[elementa], [elementA, elementB]])
        let ruleTwo = Rule(variable: elementA, rules: [[elementb], [elementA, elementB]])
        let ruleThree = Rule(variable: elementC, rules: [[elementab, elementA]])

        let rules = [ruleOne, ruleTwo, ruleThree]
        let contextFree =  ContextFree(alphabet: ["a", "b"], rules: rules)
        return contextFree
    }
}
