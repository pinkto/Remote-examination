//
//  EmailValidator.swift
//  Remote examination
//
//  Created by Anna Abdeeva on 20.03.2022.
//

import Foundation

class EmailValidator: Validator {
    fileprivate let minLength = 6
    fileprivate let maxLength = 254

    fileprivate let regex = "[A-Z0-9a-z \"._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    fileprivate let regexMinLocalPart = "[A-Z0-9a-z \"._%+-]{4,}@[A-Za-z0-9.-]+"
    fileprivate let regexMaxLocalPart = "[A-Z0-9a-z \"._%+-]{65,}@[A-Za-z0-9.-]+"

    public func isEmailLocalPartLongerThanMinLength(_ string: String) -> Bool {
        matchesRegex(stringForValidation: string, regex: regexMinLocalPart)
    }

    public func isEmailLocalPartShorterThanMaxLength(_ string: String) -> Bool {
        !matchesRegex(stringForValidation: string, regex: regexMaxLocalPart)
    }

    public func isEmailLengthCorrect(_ string: String) -> Bool {
        string.count >= minLength && string.count <= maxLength
    }

    public func isEmailValide(_ string: String) -> Bool {
        return !string.isEmpty && matchesRegex(stringForValidation: string, regex: regex) &&
            isEmailLengthCorrect(string) && isEmailLocalPartLongerThanMinLength(string) && isEmailLocalPartShorterThanMaxLength(string)
    }
}
