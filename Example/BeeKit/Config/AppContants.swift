//
//  AppContants.swift
//  BeeKit_Example
//
//  Created by liuxc on 2021/1/11.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

public let CallBackBlockKey = "callback"
public typealias CallBackBlock = DictionaryBlock
public typealias VoidBlock = () -> Void
public typealias BoolBlock = (Bool) -> Void
public typealias IntBlock  = (Int) -> Void
public typealias DictionaryBlock  = ([String: Any]) -> Void
public typealias AnyBlock  = (Any) -> Void

public typealias VoidBlock_Int = () -> Int
public typealias BoolBlock_Int = (Bool) -> Int
public typealias IntBlock_Int  = (Int) -> Int
public typealias DictionaryBlock_Int  = ([String: Any]) -> Int
public typealias AnyBlock_Int  = (Any) -> Int

public typealias VoidBlock_String = () -> String
public typealias BoolBlock_String = (Bool) -> String
public typealias IntBlock_String  = (Int) -> String
public typealias DictionaryBlock_String  = ([String: Any]) -> String
public typealias AnyBlock_String  = (Any) -> String

public typealias VoidBlock_Any = () -> Any
public typealias BoolBlock_Any = (Bool) -> Any
public typealias IntBlock_Any  = (Int) -> Any
public typealias DictionaryBlock_Any  = ([String: Any]) -> Any
public typealias AnyBlock_Any  = (Any) -> Any

// MARK: - DateFormat

struct DateFormatStyle {

    static let service_yyyymmdd = "yyyy-MM-dd"
    static let service_yyyymmddHHmm = "yyyy-MM-dd HH:mm"
    static let service_yyyyMMddHHmmss = "yyyy-MM-dd HH:mm:ss"
    static let service_MMdd = "MM-dd"

    static let hhmm = "HH:mm"
    static let yyyymmdd = "yyyy.MM.dd"
    static let yyyyMMddHHmm = "yyyy.MM.dd HH:mm"
    static let yyyyMMddHHmmss = "yyyy.MM.dd HH:mm:ss"
    static let MMddHHmm = "MM.dd HH:mm"
    static let MMddEEEHHmm = "MM月dd日  EEE  HH:mm"
    static let MMdd = "MM.dd"

}
