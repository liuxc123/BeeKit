//
//  DispatchQueueViewController.swift
//  BeeKit_Example
//
//  Created by liuxc on 2021/6/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class DispatchQueueViewController: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigation.item.title = "DispatchQueue"

        test2()
    }

    /// 串行队列+同步任务
    func test1() {
        let mainQueue = DispatchQueue.main
        let serialQueue = DispatchQueue(label: "serialQueue")

        print("主队列：\(mainQueue) \n创建的串行队列：\(serialQueue)")
        print("主线程：\(Thread.main)")

        print("主线程开始")

        serialQueue.sync {
            print("任务1执行：\(Thread.current)")
            Thread.sleep(forTimeInterval: 4)
        }

        serialQueue.sync {
            print("任务2执行：\(Thread.current)")
            Thread.sleep(forTimeInterval: 4)
        }

        print("主线程结束")
    }

    /// 2、串行队列+异步任务
    func test2() {

        let group = DispatchGroup()

        let mainQueue = DispatchQueue.main
        let serialQueue = DispatchQueue(label: "serialQueue")

        print("主队列：\(mainQueue) \n创建的串行队列：\(serialQueue)")
        print("主线程：\(Thread.main)")

        print("主线程开始")

        group.enter()
        serialQueue.async(group: group, execute: DispatchWorkItem(block: {
            print("任务1执行：\(Thread.current)")
            Thread.sleep(forTimeInterval: 4)
            group.leave()
        }))

        group.enter()
        serialQueue.async(group: group, execute: DispatchWorkItem(block: {
            print("任务2执行：\(Thread.current)")
            Thread.sleep(forTimeInterval: 4)
            group.leave()
        }))

        group.notify(queue: serialQueue, work: DispatchWorkItem(block: {
            print("任务全部完成")
        }))

        print("主线程结束")
    }

    func test3() {

    }

}
