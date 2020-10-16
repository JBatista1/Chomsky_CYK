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
        let context = uselessSymbolsRemover(inContexFree: language)
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
// MARK: - Utils function
extension Chomsky {

    func verifyExistElement(inContexnFree language: ContextFree, withAlphabet alphabet: [String]) -> [LanguageElements] {
        var elements: [LanguageElements] = []
        for rule in language.rules {
            for elementRule in rule.rules where elementRule.count == 1 {
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
