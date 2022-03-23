//
//  PasswordValidator.swift
//  Remote examination
//
//  Created by Anna Abdeeva on 20.03.2022.
//

import Foundation

class PasswordValidator: Validator {
    fileprivate let validCharactersRegex = "[a-zA-Z0-9]+"
    fileprivate let lowercaseRegex = "[a-z]+"
    fileprivate let uppercaseRegex = "[A-Z]+"
    fileprivate let digitsRegex = "[0-9]+"
    fileprivate let validLength = 8...30

    public func doesPasswordContainInvalidCharacters(_ pass: String) -> Bool {
        !pass.matches(validCharactersRegex)
    }

    public func doesPasswordContainLowercaseCharacter(_ pass: String) -> Bool {
        pass.matches(lowercaseRegex)
    }

    public func doesPasswordContainUppercaseCharacter(_ pass: String) -> Bool {
        pass.matches(uppercaseRegex)
    }

    public func doesPasswordContainDigit(_ pass: String) -> Bool {
        pass.matches(digitsRegex)
    }

    public func isPasswordLegthValid(_ pass: String) -> Bool {
        validLength.contains(pass.count)
    }

    public func isPasswordValid(_ pass: String) -> Bool {
        !doesPasswordContainInvalidCharacters(pass) && doesPasswordContainDigit(pass)
            && doesPasswordContainLowercaseCharacter(pass) && doesPasswordContainUppercaseCharacter(pass)
            && isPasswordLegthValid(pass)
    }

    public func arePasswordsEquivalent(_ pass1: String, _ pass2: String) -> Bool {
        pass1 == pass2
    }

    public func arePasswordsEquivalentAndValid(_ pass1: String, _ pass2: String) -> Bool {
        isPasswordValid(pass1) && arePasswordsEquivalent(pass1, pass2)
    }
}
