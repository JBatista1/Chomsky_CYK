//
//  CYK.swift
//  Chomsky_CYK
//
//  Created by Joao Batista on 17/10/20.
//  Copyright © 2020 Joao Batista. All rights reserved.
//

import Foundation
typealias CellMatriz = (key: String, value: [LanguageElements])
class CYK {
    let language: ContextFree
    var dataSetAlphabet: [String: [LanguageElements]] = [:]
    var matrix: [[CellMatriz]] = []
    var numberLines: Int = 0
    var belongs = false
    init(languageContext: ContextFree) {
        language = languageContext
    }

    func verify(theString textCYK: FormatTextCYK) -> Bool {
        numberLines = textCYK.string.count
        //Create first Line

        createFirstLine(textCYK: textCYK)
        let textsCombinations = createCombination(textCYK: textCYK)

        while numberLines > 0 {
            for string in textsCombinations {
                for combination in string.string {
                    let combinationPossibles = createArrayCombinationsPosibles(withString: combination)
                    var nextCell: [LanguageElements] = []
                    for finalCombination in combinationPossibles {
                        let newCombination = combine(firstElement: dataSetAlphabet[finalCombination.string.first!]!, withSecondElement: dataSetAlphabet[finalCombination.string.last!]!)
                        for element in newCombination {
                            nextCell.append(contentsOf: detectElements(inRules: language.rules, withElements: element))
                        }
                    }
                    dataSetAlphabet[combination] = nextCell.uniques
                }
                createLine(withNumberElements: numberLines, andtextCYK: string)
            }
            
        }
        return belongs
    }

    func createCombination(textCYK: FormatTextCYK) -> [FormatTextCYK] {
        var format: [FormatTextCYK] = []
        format.append(textCYK)

        var indexK = 0
        while format.count <= textCYK.string.count {
            var strings: [String] = []
            for index in 0..<format[indexK].string.count where index + 1 < format[indexK].string.count {
                strings.append("\(format[indexK].string[index])\(textCYK.string[index + format[indexK].string[index].count])")
            }
            format.append(FormatTextCYK(string: strings))
            indexK += 1
        }
        format.removeFirst()
        format.removeLast()
        return format
    }

    func createArrayCombinationsPosibles(withString string: String) -> [FormatTextCYK] {
        var format: [FormatTextCYK] = []
        for index in 0..<string.count - 1 {
            format.append(FormatTextCYK(string: [string.substring(with: 0..<index+1), string.substring(with: index + 1..<string.count)]))
        }
        return format
    }

    func createFirstLine(textCYK: FormatTextCYK) {
        for string in textCYK.string {
            dataSetAlphabet[string] = detectElements(inRules: language.rules, withValue: string)
        }
        createLine(withNumberElements: textCYK.string.count, andtextCYK: textCYK)
    }

    func detectElements(inRules rules: [Rule], withValue value: String) -> [LanguageElements] {
        var elements:[LanguageElements] = []
        for rule in rules {
            for elementRule in rule.rules  where elementRule.count == 1 && elementRule.first?.name == value {
                elements.append(rule.variable)
            }
        }
        return elements
    }

    func detectElements(inRules rules: [Rule], withElements value: [LanguageElements]) -> [LanguageElements] {
        var elements: [LanguageElements] = []
        for rule in rules {
            for elementRule in rule.rules  where elementRule == value {
                elements.append(rule.variable)
            }
        }
        return elements
    }

    func combine(firstElement elementOne: [LanguageElements], withSecondElement elementoTwo: [LanguageElements]) -> [[LanguageElements]] {
        var elements: [[LanguageElements]] = []
        for first in elementOne {
            for second in elementoTwo {
                elements.append([first, second])
            }
        }
        return elements
    }

    func createLine(withNumberElements number: Int, andtextCYK text: FormatTextCYK) {
        var line: [CellMatriz] = []
        for index in 0..<number {
            let cell = CellMatriz(text.string[index], dataSetAlphabet[text.string[index]]!)
            line.append(cell)
        }
        matrix.append(line)
        numberLines -= 1
        if numberLines == 0 {
            belongs = valideVariable()
        }
    }

    func valideVariable() -> Bool {
        guard let elementsFinals = matrix.last?.first else {return false}
        if elementsFinals.value.contains(language.initialSymbol){
            return true
        }
        return false
    }

}
