//
//  UIFont+Extensions.swift
//  BEEKit-Swift
//
//  The MIT License (MIT)
//
//  Copyright (c) 2015 - 2019 Fabrizio Brancati.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import Foundation
import UIKit

// MARK: - UIFont extension

/// This extesion adds some useful functions to UIFont.
public extension UIFont {

    // MARK: - Functions

    /// Print in console all family and font names.
    ///
    /// - Returns: Returns all the font family names.
    static func allFonts() -> [String: [String]] {
        var fontFamilies = UIFont.familyNames
        var fontFamilyDictionary: [String: [String]] = [:]
        
        fontFamilies.sort { $0 < $1 }
        
        for fontFamily in fontFamilies {
            let fontNames: [String] = UIFont.fontNames(forFamilyName: fontFamily).sorted { $0 < $1 }
            fontFamilyDictionary[fontFamily] = fontNames
        }
        
        return fontFamilyDictionary
    }
    
    /// Calculate text height for max width and font.
    ///
    /// - Parameters:
    ///   - width: Max width to fit text.
    ///   - font: Font used in text.
    ///   - text: Text.
    /// - Returns: Returns calculated height of string within width using given font.
    static func calculateHeight(width: CGFloat, font: UIFont, text: String) -> CGFloat {
        var size = CGSize.zero
        
        if !text.isEmpty {
            let frame: CGRect = text.boundingRect(with: CGSize(width: width, height: 999_999), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
            size = CGSize(width: frame.size.width, height: frame.size.height + 1)
        }
        return size.height
    }

    /// IconFont name:font-family forClass:class  from: pod resource_bundles key
    static func iconFont(_ name: String, size: CGFloat, forClass: AnyClass? = nil, from: String? = nil) -> UIFont {
        if let clas = forClass, let bu = Bundle.bundle(clas, from) {
            let path = String(format: "%@/%@.ttf", bu.bundlePath, name)
            return UIFont.iconFont(name, size: size, url:URL(fileURLWithPath: path))
        }
        else if let font = UIFont(name: name, size: size){
            return font
        }
        else{
            // 如果info.plist没有添加 Fonts provided by application 则可以直接检索 Bundle 读取
            guard let url = Bundle.main.url(forResource: name, withExtension: "ttf") else {
                assertionFailure("👉👉👉IconFont-请确认\(name).ttf 和 font-family是否配置正确  👻")
                return UIFont.systemFont(ofSize: size)
            }
            return UIFont.iconFont(name, size: size, url:url)
        }
    }

    /// IconFont name:font-family url: Bundle url
    static func iconFont(_ name:String, size:CGFloat, url:URL) -> UIFont {
        guard let data = try? Data(contentsOf: url) else {
            assertionFailure("👉👉👉IconFont- 失败  👻")
            return UIFont.systemFont(ofSize: size)
        }
        guard let provider = CGDataProvider.init(data: data as CFData) else {
            assertionFailure("👉👉👉IconFont- 失败  👻")
            return UIFont.systemFont(ofSize: size)
        }
        guard let fontCG = CGFont(provider) else{
            assertionFailure("👉👉👉IconFont- 失败  👻")
            return UIFont.systemFont(ofSize: size)
        }
        CTFontManagerRegisterGraphicsFont(fontCG, nil)
        guard let font = UIFont(name: name, size: size) else{
            assertionFailure("👉👉👉IconFont-请确认\(name).ttf 和 font-family是否配置正确  👻")
            return UIFont.systemFont(ofSize: size)
        }
        return font
    }
}
