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
    // Teste com variaveis dupla a, b como letrar entre variaveis
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
        let ruleThree = Rule(variable: elementC, rules: [[elementab, elementa, elementA]])

        let rules = [ruleOne, ruleTwo, ruleThree]
        let contextFree =  ContextFree(alphabet: ["a", "b"], rules: rules)
        return contextFree
    }
    // Exemplo com Epsilon Transition
    static func getExempleThree() -> ContextFree {
        let elementS = LanguageElements(name: "S", type: .variable)
        let elementA = LanguageElements(name: "A", type: .variable)
        let elementB = LanguageElements(name: "B", type: .variable)
        let elementa = LanguageElements(name: "a", type: .alphabet)
        let elementb = LanguageElements(name: "b", type: .alphabet)
        let elementEpsilon = LanguageElements(name: String.epsilon, type: .alphabet)

        let ruleOne = Rule(variable: elementS, rules: [[elementA, elementS, elementA], [elementa, elementB]])
        let ruleTwo = Rule(variable: elementA, rules: [[elementB], [elementS]])
        let ruleThree = Rule(variable: elementB, rules: [[elementb], [elementEpsilon]])

        let rules = [ruleOne, ruleTwo, ruleThree]
        let contextFree =  ContextFree(alphabet: ["a", "b"], rules: rules)
        return contextFree
    }
    static func getExempleFour() -> ContextFree {
        let elementS = LanguageElements(name: "S", type: .variable)
        let elementA = LanguageElements(name: "A", type: .variable)
        let elementB = LanguageElements(name: "B", type: .variable)
        let elementC = LanguageElements(name: "C", type: .variable)
        let element0 = LanguageElements(name: "0", type: .alphabet)
        let element1 = LanguageElements(name: "1", type: .alphabet)
        let elementEpsilon = LanguageElements(name: String.epsilon, type: .alphabet)

        let ruleOne = Rule(variable: elementS, rules: [[element0, elementA, element0], [element1, elementB, element1], [elementB, elementB]])
        let ruleTwo = Rule(variable: elementA, rules: [[elementC]])
        let ruleThree = Rule(variable: elementB, rules: [[elementS], [elementA]])
        let ruleFour = Rule(variable: elementC, rules: [[elementS], [elementEpsilon]])

        let rules = [ruleOne, ruleTwo, ruleThree, ruleFour]
        let contextFree =  ContextFree(alphabet: ["1", "0", String.epsilon], rules: rules)
        return contextFree
    }
    static func getExempleFive() -> ContextFree {
        let elementS = LanguageElements(name: "S", type: .variable)
        let elementA = LanguageElements(name: "A", type: .variable)
        let elementB = LanguageElements(name: "B", type: .variable)
        let elementa = LanguageElements(name: "a", type: .alphabet)
        let elementb = LanguageElements(name: "b", type: .alphabet)
        let elementEpsilon = LanguageElements(name: String.epsilon, type: .alphabet)

        let ruleOne = Rule(variable: elementS, rules: [[elementA, elementB]])
        let ruleTwo = Rule(variable: elementA, rules: [[elementa, elementA, elementA], [elementEpsilon]])
        let ruleThree = Rule(variable: elementB, rules: [[elementb, elementB, elementB], [elementEpsilon]])

        let rules = [ruleOne, ruleTwo, ruleThree]
        let contextFree = ContextFree(alphabet: ["a", "b"], rules: rules)
        return contextFree
    }
}
