//
//  StringExtension.swift
//  Chomsky_CYK
//
//  Created by Joao Batista on 16/10/20.
//  Copyright © 2020 Joao Batista. All rights reserved.
//

import Foundation

extension String {
    static var epsilon: String = "ε"
    
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    
    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return String(self[fromIndex...])
    }
    
    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return String(self[..<toIndex])
    }
    
    func substring(with rang: Range<Int>) -> String {
        let startIndex = index(from: rang.lowerBound)
        let endIndex = index(from: rang.upperBound)
        return String(self[startIndex..<endIndex])
    }
    
}
