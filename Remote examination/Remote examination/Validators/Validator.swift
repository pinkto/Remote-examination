//
//  Validator.swift
//  Remote examination
//
//  Created by Anna Abdeeva on 20.03.2022.
//

import Foundation

class Validator {
    internal func matchesRegex(stringForValidation string: String, regex: String) -> Bool {
        return string.matches(regex)
    }
}

extension String {
    func matches(_ regex: String) -> Bool {
        return self.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
}
