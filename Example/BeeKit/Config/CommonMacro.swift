//
//  CommonMacro.swift
//  BeeKit_Example
//
//  Created by liuxc on 2021/1/11.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import SwifterSwift

// MARK: - 变量

/// 屏幕宽度，会根据横竖屏的变化而变化
public var SCREEN_WIDTH: CGFloat { UIScreen.screenHeight }

/// 屏幕高度，会根据横竖屏的变化而变化
public var SCREEN_HEIGHT: CGFloat { UIScreen.screenWidth }

/// 一像素尺寸
public var OnePixle: CGFloat { UIScreen.onePixle }

/// SafeAreaInsets
public var GET_SAFEAREA_INSETS: UIEdgeInsets {
    if #available(iOS 11.0, *) {
        return UIApplication.shared.keyWindow?.safeAreaInsets ?? UIEdgeInsets.zero
    }
    return UIEdgeInsets.zero
}

/// 导航栏高度
public let GET_NAVIGATION_BAR_HEIGHT: CGFloat = 44

/// 导航栏最大Y值
public var GET_NAVIGATION_BAR_MAXY: CGFloat {
    var top = GET_SAFEAREA_INSETS.top
    top = top > 0 ? top : 20
    return top + GET_NAVIGATION_BAR_HEIGHT
}

/// tabbar高度
public var GET_TABBAR_HEIGHT: CGFloat {
    return 49.0 + GET_SAFEAREA_INSETS.bottom
}


// MARK: - 方法-创建器

// MARK: UIImage

/// 使用文件名(不带后缀名)创建一个UIImage对象，会被系统缓存，适用于大量复用的小资源图
/// 使用这个 API 而不是 imageNamed: 是因为后者在 iOS 8 下反而存在性能问题（by molice 不确定 iOS 9 及以后的版本是否还有这个问题）
public let UIImageMake: (String) -> UIImage? = { UIImage(named: $0, in: nil, compatibleWith: nil) }

/// 使用文件名(不带后缀名，仅限png)创建一个UIImage对象，不会被系统缓存，用于不被复用的图片，特别是大图
public let UIImageMakeWithFile: (String) -> UIImage? = { UIImageMakeWithFileAndSuffix($0, "png") }
public let UIImageMakeWithFileAndSuffix: (String, String) -> UIImage? = { UIImage(contentsOfFile: "\(Bundle.main.resourcePath ?? "")/\($0).\($1)") }

// MARK: UIFont

// 字体相关的宏，用于快速创建一个字体对象，更多创建宏可查看 UIFont+QMUI.swift
public let UIFontMake: (CGFloat) -> UIFont = { UIFont.systemFont(ofSize: $0).auto() }
/// 斜体只对数字和字母有效，中文无效
public let UIFontItalicMake: (CGFloat) -> UIFont = { UIFont.italicSystemFont(ofSize: $0).auto() }
public let UIFontBoldMake: (CGFloat) -> UIFont = { UIFont.boldSystemFont(ofSize: $0.auto()) }
public let UIFontBoldWithFont: (UIFont) -> UIFont = { UIFont.boldSystemFont(ofSize: $0.pointSize).auto() }
