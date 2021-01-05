//
//  LimitInputReplace.swift
//  LimitInput
//
//  Created by liuxc on 2019/10/16.
//  Copyright © 2019 liuxc. All rights reserved.
//

import UIKit

public struct LimitInputReplace {

    var key: String = ""
    var value: String = ""
    var regex: String = ""

    var chars = [Character]()
    var offset: Int { return value.count - key.count }

    public init(from: String, of: String) {
        self.key = from
        self.value = of
        self.chars = from.map({ (char) -> Character in
            return char
        })
    }

    public init(regex: String, of: String) {
        self.regex = regex
        self.value = of
    }
}

