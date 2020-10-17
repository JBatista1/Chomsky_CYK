//
//  main.swift
//  Chomsky_CYK
//
//  Created by Joao Batista on 16/10/20.
//  Copyright © 2020 Joao Batista. All rights reserved.
//

import Foundation

//let exemple = Exemples.getExempleOne()
//let exemple = Exemples.getExempleTwo()
//let exemple = Exemples.getExempleThree()
//let exemple = Exemples.getExempleFour()
let exemple = Exemples.getExempleFive()
let chomsky = Chomsky(language: exemple)
chomsky.generateChomskyFormatter()
print("\(exemple.initialSymbol)")
