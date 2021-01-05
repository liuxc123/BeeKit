//
//  LimitInputMatchConstant.swift
//  AwesomeProject
//
//  Created by liuxc on 2019/10/16.
//  Copyright © 2019 liuxc. All rights reserved.
//

import Foundation

public struct MatchHeader {
    struct Name {
        static let kRegExHeader = "SELF MATCHES %@"
    }
}


public struct MatchConstant {
    struct Name {
        static let limitedTextZeroRegEx = "^[0][0-9]+$"// 匹 0 开头
        static let limitedTextNumberOnlyRegex = "^[0-9]*$";
        static let limitedTextZeroOrNonRegex = "^(0|[1-9][0-9]*)$";
        static let limitedTextChineseOnlyRegex = "^[\\u4e00-\\u9fa5]{0,}$";
        static let limitedTextEnglishOnlyRegex = "^[A-Za-z]+$";
    }
}

public enum MatchVariables {
    public static var limitedTextNumberFloatSeparators = "."
}
