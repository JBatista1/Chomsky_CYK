//
//  Exemples.swift
//  Chomsky_CYK
//
//  Created by Joao Batista on 16/10/20.
//  Copyright © 2020 Joao Batista. All rights reserved.
//

import Foundation

class Exemples {
    static func getExempleOneList() -> ContextFree {
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
    static func getExempleTwoList() -> ContextFree {
        //Variables
        let elementD = LanguageElements(name: "D", type: .variable)
        let elementH = LanguageElements(name: "H", type: .variable)
        let elementI = LanguageElements(name: "I", type: .variable)
        let elementL = LanguageElements(name: "L", type: .variable)
        let elementM = LanguageElements(name: "M", type: .variable)
        let elementO = LanguageElements(name: "O", type: .variable)
        let elementT = LanguageElements(name: "T", type: .variable)

        //Alphabet
        let elementHtmlOpen = LanguageElements(name: "<html>", type: .alphabet)
        let elementHtmlClose = LanguageElements(name: "</html>", type: .alphabet)
        let elementHeadOpen = LanguageElements(name: "<head>", type: .alphabet)
        let elementHeadClose = LanguageElements(name: "</head>", type: .alphabet)
        let elementTitleOpen = LanguageElements(name: "<titlel>", type: .alphabet)
        let elementTitleClose = LanguageElements(name: "</title>", type: .alphabet)
        let elementBodyOpen = LanguageElements(name: "<body>", type: .alphabet)
        let elementBodyClose = LanguageElements(name: "</body>", type: .alphabet)
        let elementBOpen = LanguageElements(name: "<b>", type: .alphabet)
        let elementBClose = LanguageElements(name: "</b>", type: .alphabet)
        let elementULOpen = LanguageElements(name: "<ul>", type: .alphabet)
        let elementULClose = LanguageElements(name: "</ul>", type: .alphabet)
        let elementOLOpen = LanguageElements(name: "<ol>", type: .alphabet)
        let elementOLClose = LanguageElements(name: "</ol>", type: .alphabet)
        let elementLIOpen = LanguageElements(name: "<li>", type: .alphabet)
        let elementLIClose = LanguageElements(name: "</li>", type: .alphabet)
        let elementTheory = LanguageElements(name: "theory of computation", type: .alphabet)
        let elementAutomata = LanguageElements(name: "automata", type: .alphabet)
        let elementSpace = LanguageElements(name: " ", type: .alphabet)
        let elementGrammars = LanguageElements(name: "grammars", type: .alphabet)

        let ruleOne = Rule(variable: elementD, rules: [[elementHtmlOpen, elementHeadOpen, elementTitleOpen, elementT,
                                                        elementTitleClose, elementHeadClose, elementBodyOpen, elementH, elementBodyClose,elementHtmlClose]])
        let ruleTwo = Rule(variable: elementH, rules: [[elementI, elementH], [elementI]])
        let ruleThree = Rule(variable: elementI, rules: [[elementBOpen, elementH, elementBClose], [elementT], [elementL]])
        let ruleFour = Rule(variable: elementL, rules: [[elementULOpen, elementM, elementULClose], [elementOLOpen, elementM, elementOLClose]])
        let ruleFive = Rule(variable: elementM, rules: [[elementM, elementO], [elementO]])
        let ruleSix = Rule(variable: elementO, rules: [[elementLIOpen, elementH, elementLIClose]])
        let ruleSeven = Rule(variable: elementT, rules: [[elementTheory, elementSpace, elementAutomata, elementGrammars]])

        let rules: [Rule] = [ruleOne, ruleTwo, ruleThree, ruleFour, ruleFive, ruleSix, ruleSeven]
        let contextFree =  ContextFree(alphabet: ["<html>", "</html>", "<head>", "</head>", "<title>", "</title>", "<body>", "</body>",
                                                  "<b>", "</b>", "<ul>", "</ul>", "<ol>", "</ol>", "<li>", "</li>",
                                                  "theory of computation, automata", "grammars", " "], rules: rules)
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

    static func getExempleLanguageCYK() -> ContextFree {
        let elementS = LanguageElements(name: "S", type: .variable)
        let elementA = LanguageElements(name: "A", type: .variable)
        let elementB = LanguageElements(name: "B", type: .variable)
        let elementC = LanguageElements(name: "C", type: .variable)
        let elementa = LanguageElements(name: "a", type: .alphabet)
        let elementb = LanguageElements(name: "b", type: .alphabet)

        let ruleOne = Rule(variable: elementS, rules: [[elementA, elementB], [elementB, elementC]])
        let ruleTwo = Rule(variable: elementA, rules: [[elementB, elementA], [elementa]])
        let ruleThree = Rule(variable: elementB, rules: [[elementC, elementC], [elementb]])
        let ruleFour = Rule(variable: elementC, rules: [[elementA, elementB], [elementa]])

        let rules = [ruleOne, ruleTwo, ruleThree, ruleFour]
        let contextFree = ContextFree(alphabet: ["a", "b"], rules: rules)
        return contextFree
    }
}
