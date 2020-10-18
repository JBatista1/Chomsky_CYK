//
//  main.swift
//  Chomsky_CYK
//
//  Created by Joao Batista on 16/10/20.
//  Copyright © 2020 Joao Batista. All rights reserved.
//

import Foundation


//Exemple List one question 2
let logicExemple = Exemples.getExempleOneList()
let logicChomsky = Chomsky(language: logicExemple)
let logicChomskyForm = logicChomsky.generateChomskyFormatter()
let logicCYK = CYK(languageContext: logicChomskyForm)

//Valid test
let logicStringValid1 = FormatTextCYK(string: ["p", "->", "p"])
let logicStringValid2 = FormatTextCYK(string: ["p", "->", "(", "p", "\\/", "r", ")"])
logicCYK.verify(theString: logicStringValid1)
logicCYK.verify(theString: logicStringValid2)

//Invalid Test
let logicStringInvalid1 = FormatTextCYK(string: ["p", "->"])
let logicStringInvalid2 = FormatTextCYK(string: ["p", "->", "p", "\\/", "r", ")"])
logicCYK.verify(theString: logicStringInvalid1)
logicCYK.verify(theString: logicStringInvalid2)
//


//Exemple List one question 2
let htmlExemple = Exemples.getExempleTwoList()
let htmlChomsky = Chomsky(language: htmlExemple)
let htmlChomskyFormat = htmlChomsky.generateChomskyFormatter()
let htmlCYK = CYK(languageContext: htmlChomskyFormat)
//Valid test
let htmlStringValid1 = FormatTextCYK(string: ["<html>", "<head>", "<title>", "theory of computation", "</title>", "</head>",
                                              "<body>", "automata", "</body>", "</html>"])
let htmlStringValid2 = FormatTextCYK(string: ["<html>", "<head>", "<title>", "theory of computation", "</title>", "</head>",
                                              "<body>", "<b>", "automata", " ", "grammars", "</b>", "</body>", "</html>"])
htmlCYK.verify(theString: htmlStringValid1)
htmlCYK.verify(theString: htmlStringValid2)
//
let htmlStringInvalid1 = FormatTextCYK(string: ["<html>", "<head>", "<title>", "theory of computation", "</title>", "</head>",
                                              "<body>", "<b>", "automata", " ", "grammars", "</body>", "</html>"])

let htmlStringInvalid2 = FormatTextCYK(string: ["<html>", "<head>", "<title>", "</title>", "</head>",
                                                                       "<body>", "automata", "</body>", "</html>"])
htmlCYK.verify(theString: htmlStringInvalid1)
htmlCYK.verify(theString: htmlStringInvalid2)

//Exemple video aula
let exempleLangaueCYK = Exemples.getExempleLanguageCYK()
let cyk = CYK(languageContext: exempleLangaueCYK)
let myString = FormatTextCYK(string: ["b", "a", "a", "b", "a"])
cyk.verify(theString: myString )



