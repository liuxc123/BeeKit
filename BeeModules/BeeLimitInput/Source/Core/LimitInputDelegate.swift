//
//  LimitInputDelegate.swift
//  LimitInput
//
//  Created by liuxc on 2019/10/16.
//  Copyright © 2019 liuxc. All rights reserved.
//

import UIKit

public class LimitInputDelegate: NSObject {
    private(set) weak var textInputDelegate: AnyObject?

    public init(delegate: AnyObject?) {
        self.textInputDelegate = delegate
    }
}

