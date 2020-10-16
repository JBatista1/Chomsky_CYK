//
//  LanguageElements.swift
//  Chomsky_CYK
//
//  Created by Joao Batista on 16/10/20.
//  Copyright © 2020 Joao Batista. All rights reserved.
//

import Foundation
struct LanguageElements {
    let name: String
    let type: TypeVariable
}

extension LanguageElements: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(LanguageElements.self).hashValue)
    }
    static func == (lhs: LanguageElements, rhs: LanguageElements) -> Bool {
        return lhs.name == rhs.name && lhs.type == rhs.type
    }
}
