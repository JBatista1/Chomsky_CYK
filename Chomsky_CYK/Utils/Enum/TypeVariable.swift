//
//  TypeVariable.swift
//  Chomsky_CYK
//
//  Created by Joao Batista on 16/10/20.
//  Copyright © 2020 Joao Batista. All rights reserved.
//

import Foundation

typealias LanguageElements = (name: String, type: TypeVariable)

enum TypeVariable {
    case alphabet
    case variable
}
