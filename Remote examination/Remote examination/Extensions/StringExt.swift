//
//  StringExt.swift
//  Remote examination
//
//  Created by Anna Abdeeva on 22.03.2022.
//

import Foundation

extension String {
    var base64Encoded: String? {
        return self.data(using: .utf8)?.base64EncodedString()
    }
}
