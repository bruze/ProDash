//
//  REGEX.swift
//  ProDash
//
//  Created by Bruno Garelli on 10/15/20.
//

import Foundation
extension String {
    var textBetween: ((String, String)) -> String {
        get {
            { bounds in
                let (initialChar, finalChar) = bounds
                if let range = self.range(of: #"\\#(initialChar)(.*)\#(finalChar)"#, options: .regularExpression) {
                    return String(self[range].dropFirst().dropLast())
                }
                return self
            }
        }
    }
}
