//
//  main.swift
//  Chomsky_CYK
//
//  Created by Joao Batista on 16/10/20.
//  Copyright © 2020 Joao Batista. All rights reserved.
//

import Foundation

//let exemple = Exemples.getExempleOneList()
//let exemple = Exemples.getExempleTwo()
//let exemple = Exemples.getExempleThree()
//let exemple = Exemples.getExempleFour()
//let exemple = Exemples.getExempleFive()
//let exemple = Exemples.getExempleTwoList()
//let chomsky = Chomsky(language: exemple)
//let languageChomskyFormat = chomsky.generateChomskyFormatter()
let exempleLangaueCYK = Exemples.getExempleLanguageCYK()
let cyk = CYK(languageContext: exempleLangaueCYK)
let myString = FormatTextCYK(string: ["b", "a", "a", "b", "a"])
if cyk.verify(theString: myString ) {
    print("A String é aceita")
} else {
    print("A String não é aceita")
}

//print("\(exemple.initialSymbol)")
