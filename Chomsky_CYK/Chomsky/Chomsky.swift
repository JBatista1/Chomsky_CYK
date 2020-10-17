//
//  Chomsky.swift
//  Chomsky_CYK
//
//  Created by Joao Batista on 16/10/20.
//  Copyright © 2020 Joao Batista. All rights reserved.
//

import Foundation

protocol ChomskyProtocol: AnyObject {
    func uselessSymbolsRemover(inContexFree language: ContextFree) -> ContextFree
}

class Chomsky {
    let language: ContextFree
    let initialSymbol: LanguageElements
    init(language: ContextFree) {
        self.language = language
        self.initialSymbol = language.initialSymbol
    }

    func generateChomskyFormatter() -> ContextFree {
        var context = uselessSymbolsRemover(inContexFree: language)
        context = verifyInitialVariable(inContextFree: context)
        context = removeEpsilon(inContextFree: context)
        return context
    }

}

extension Chomsky: ChomskyProtocol {
    func uselessSymbolsRemover(inContexFree language: ContextFree) -> ContextFree {
        var contextfree = language
        contextfree.rules = removeVoidElement(inRules: contextfree.rules)
        var elementsValid = verifyExistElement(inContexnFree: language, withAlphabet: language.alphabet)
        elementsValid = verifyExistElement(inContexnFree: language, withElementsValid: elementsValid)
        contextfree = removeElementsNotValid(inContexnFree: contextfree, withElementsValid: elementsValid)
        contextfree = removeUnreachableElements(inContextFree: contextfree)
        contextfree.rules = removeVoidElement(inRules: contextfree.rules)
        return contextfree
    }

}

// MARK: - Utils function Update Initial Rule
extension Chomsky {
    func verifyInitialVariable(inContextFree language: ContextFree) -> ContextFree {
        let contextFree = language
        var constainsInitial = false
        for rules in language.rules {
            for rule in rules.rules {
                if rule.contains(initialSymbol) {
                    constainsInitial = true
                }
            }

        }
        if constainsInitial {
            let initialS0 = LanguageElements(name: "S0", type: .variable)
            let rule = Rule(variable: initialS0, rules: [[language.initialSymbol]])
            contextFree.initialSymbol = initialS0
            var rules = [rule]
            rules.append(contentsOf: contextFree.rules)
            contextFree.rules = rules
        }
        return contextFree
    }

}
// MARK: - Utils function Eliminet epsilon
extension Chomsky {
    func removeEpsilon(inContextFree language: ContextFree) -> ContextFree {
        var contextFree = language
        var detect = detectEpsilon(inContextFree: contextFree)
        while detect != initialSymbol {
            guard let element = detect else {return contextFree}
            for index in 0..<contextFree.rules.count {
                if contextFree.rules[index].variable == element {
                    contextFree.rules[index] = remove(theElement: String.epsilon, inRule: language.rules[index])
                }
            }
            contextFree = updateRules(inContextFree: contextFree, usignElemente: element)
            detect = detectEpsilon(inContextFree: contextFree)
        }
        return contextFree
    }

    func detectEpsilon(inContextFree language: ContextFree) -> LanguageElements? {
        for rules in language.rules {
            for elementeRules in rules.rules {
                for element in elementeRules  where element.name == String.epsilon && rules.variable != language.initialSymbol {
                    return rules.variable
                }
            }
        }
        return nil
    }

    func updateRules(inContextFree language: ContextFree, usignElemente element: LanguageElements ) -> ContextFree {
        let contextFree = language
        var index = 0
        for rules in contextFree.rules {
            for elementRule in rules.rules {
                var stop = false
                for languageElement in elementRule where languageElement == element {
                    if !stop {
                        contextFree.rules[index] = removeEpsilonStates(inRules: rules, withelElemente: element)
                        stop = true
                    }
                }
                stop = false
            }
            index += 1
        }

        return contextFree
    }

    func remove(theElement element: String, inRule rule: Rule) -> Rule {
        var ruleValid = rule

        for index in 0..<rule.rules.count {
            var indexJ = 0
            for epsilon in rule.rules[index] {
                if epsilon.name == element {
                    ruleValid.rules.remove(at: index)
                }
                indexJ += 1
            }
        }
        return ruleValid
    }
    func removeAndAddEpsilom(theElement element: String, inRule rule: Rule) -> Rule {
        var ruleValid = rule
        for index in 0..<rule.rules.count {
            for epsilon in rule.rules[index] where epsilon.name == element {
                ruleValid.rules[index].append(LanguageElements(name: String.epsilon, type: .alphabet))
            }
        }
        return ruleValid
    }

    func removeEpsilonStates(inRules rules: Rule, withelElemente element: LanguageElements) -> Rule {
        var myRule = rules
        var index = 0
        for rule in rules.rules {
            for languageElement in rule {
                if languageElement == element {
                    if rule.count == 1 {
                        myRule.rules.append([LanguageElements(name: String.epsilon, type: .alphabet)])
                    }
                    myRule.rules.append(contentsOf: newsElements(theElemente: element, theElements: rule))
                    myRule.rules = myRule.rules.uniques

                }
            }
            index += 1
        }
        return myRule
    }
    // Cria as combincações com as posibilidades de epsilon
    func newsElements(theElemente element: LanguageElements, theElements elements: [LanguageElements]) -> [[LanguageElements]] {
        var elementsArray: [[LanguageElements]] = []
        var positions = number(ofElement: element, InArrayElements: elements)
        var tempElements = elements
        for _ in 0..<tempElements.count - positions {
            tempElements.remove(at: positions)
            if tempElements.count != 0 {
                elementsArray.append(tempElements.uniques)
                positions = number(ofElement: element, InArrayElements: tempElements)
            }
        }
        return elementsArray.uniques
    }
    func number(ofElement element: LanguageElements, InArrayElements elements: [LanguageElements]) -> Int {
        var index = 0
        for languageElement in elements {
            if element == languageElement {
                return index
            }
            index += 1
        }
        return 0

    }
}
// MARK: - Utils function uselessSymbolsRemover
extension Chomsky {

    func verifyExistElement(inContexnFree language: ContextFree, withAlphabet alphabet: [String]) -> [LanguageElements] {
        var elements: [LanguageElements] = []
        for rule in language.rules {
            for elementRule in rule.rules {
                var allElement = true
                for element in elementRule where element.type != .alphabet {
                    allElement = false
                }
                if allElement {
                    elements.append(rule.variable)
                }
                allElement = false
            }
        }
        return elements.uniques
    }

    func verifyExistElement(inContexnFree language: ContextFree, withElementsValid elements: [LanguageElements]) -> [LanguageElements] {
        var elementsValid = elements
        var numberElement = elementsValid.count
        var stopWhile = false
        while !stopWhile {
            for rule in language.rules {
                for elementRule in rule.rules {
                    var allElement = true
                    for element in elementRule {
                        allElement = elementsValid.contains(element)
                    }
                    if allElement == true {
                        elementsValid.append(rule.variable)
                    }
                }
            }
            elementsValid = elementsValid.uniques
            if numberElement == elementsValid.count {
                stopWhile = true
            } else {
                numberElement = elementsValid.count
            }
        }
        return elementsValid.uniques
    }

    func removeElementsNotValid(inContexnFree language: ContextFree, withElementsValid elements: [LanguageElements]) -> ContextFree {
        var index = 0
        for rule in language.rules {
            for elementRules in rule.rules {
                for element in elementRules where element.type == .variable {
                    if elements.contains(element) == false {
                        language.rules[index].rules  =  language.rules[index].rules.filter { $0 != elementRules }
                    }
                }
            }
            index += 1
        }
        return language
    }

    func removeUnreachableElements(inContextFree language: ContextFree) -> ContextFree {
        var contextFree = language
        var validElement = getInitialVariables(inContexFree: contextFree, andRules: language.rules.first!.rules)
        var numberElement = validElement.count
        var stopWhile = false
        while !stopWhile {
            for rule in contextFree.rules {
                for element in validElement where element == rule.variable {
                    validElement.append(contentsOf: getNextVariable(inContextFree: contextFree, ofType: element))
                    validElement = validElement.uniques
                }
            }

            if numberElement == validElement.count {
                stopWhile = true
            } else {
                numberElement = validElement.count
            }
        }

        if validElement.count == 0 {
            let rule = contextFree.rules.first!
            contextFree.rules.removeAll()
            contextFree.rules.append(rule)
        } else {
            contextFree = removeElementsNotValid(inContexnFree: contextFree, withElementsValid: validElement)
        }
        return contextFree
    }

    func getInitialVariables(inContexFree language: ContextFree, andRules rules: [[LanguageElements]] ) -> [LanguageElements] {
        var validLanguage: [LanguageElements] = []
        for rule in rules {
            for element in rule where element.type == .variable {
                validLanguage.append(element)
            }
        }
        return validLanguage.uniques
    }
    func getNextVariable(inContextFree language: ContextFree, ofType type: LanguageElements) -> [LanguageElements] {
        var nextVariables: [LanguageElements] = []
        for rule in language.rules where rule.variable == type {
            for elementRule in rule.rules {
                for element in elementRule where element.type == .variable {
                    nextVariables.append(element)
                }
            }
        }
        return nextVariables.uniques
    }
    func removeVoidElement(inRules rules: [Rule]) -> [Rule] {
        var validRules: [Rule] = []
        for rule in rules where rule.rules.count > 0 {
            validRules.append(rule)
        }
        return validRules
    }
}
