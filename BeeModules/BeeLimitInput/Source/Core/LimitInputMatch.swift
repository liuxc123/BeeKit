//
//  LimitInputMatch.swift
//  LimitInput
//
//  Created by liuxc on 2019/10/16.
//  Copyright © 2019 liuxc. All rights reserved.
//

import UIKit

public struct LimitInputMatch {
    var code: (_ text: String) -> Bool
    public init(rule: @escaping (_ text: String) -> Bool) {
        self.code = rule
    }

    public init(regex: String) {
        self.init { (text) -> Bool in
            do {
                let reg = try NSRegularExpression(pattern: regex, options: .caseInsensitive)
                return !reg.matches(in: text, options: [], range: NSMakeRange(0, text.utf16.count)).isEmpty
            }catch{
                return true
            }
        }
    }
}
