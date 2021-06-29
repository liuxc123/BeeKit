//
//  RunloopViewController.swift
//  BeeKit_Example
//
//  Created by liuxc on 2021/6/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class RunloopViewController: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigation.item.title = "Runloop"

        /*
         链接：https://www.jianshu.com/p/b7bc7b5b1dc0

         1. 什么是Runloop?
         Runloop字面意思就是运行循环，在程序循环中做一些事情

         2. runloop的作用？
            1.保持程序持续运行
            2.处理程序的各种事件（PerformSelector、Timer、触摸事件等等）
            3.节省cpu资源、提高程序的性能；该做事时做事，该休息时休息
            ...

         3. 应用范畴
            1. 定时器（Timer）、PerformSelector
            2. GCD Async Main Queue
            3. 事件响应、手势识别、界面刷新
            4. 网络请求
            5. AutoReleasePool

         4. runloop与线程之间的关系

            1. 每条线程都有唯一的一个与之对应的Runloop对象
            2. Runloop保存在一个全局的Dictionary里，线程为key，Runloop为value
            3. 线程刚创建时并没有Runloop对象，Runloop会在第一次获取时创建（[NSRunloop currentRunloop]）
            4. Runloop会在线程结束时销毁
            5. 主线程的Runloop已经自动获取（创建），子线程默认没有开启Runloop

            获取Runloop的方法

            1. OC方法
            [NSRunLoop currentRunloop]; //获得当前线程的Runloop对象
            [NSRunloop mainRunloop]; //获得主线程的Runloop对象

            2. C语音方法
            CFRunloopGetCurrent();  //获得当前线程的Runloop对象
            CFRunloopGetMain(); //获得主线程的Runloop对象

         5. RunLoop相关的类

            CFRunloopRef
            CFRunloopModeRef
            CGRunloopSourceRef
            CFRunloopTimerRef
            CGRunloopObserverRef


         6. RunLoop的运行逻辑
            Source0的作用
            1、触摸事件处理
            2、PerformSelector:onThread:

            source1的作用
            1、基于Port的线程间通信
            2、系统事件捕捉

            Timers的作用
            1. NSTimer
            2. PerformSelector：withObject：afterDelay：

            Observers作用
            1、用于监听Runloop的作用
            根据runloop的状态来做相应的事情 如：UI刷新（BeforeWaiting）、Autorelease pool（BeforeWaiting）等

            流程
            01、通知Observers：进入Loop
            02、通知Observers：即将处理Timers
            03、通知Observers：即将处理Sources
            04、处理Blocks
            05、处理Source0（可能会再次处理Blocks）
            06、如果存在Source1，就跳转到第8步
            07、通知Observers：开始休眠（等待消息唤醒）
            08、通知Observers：结束休眠（被某个消息唤醒）
                01> 处理Timer
                02> 处理GCD Async To Main Queue
                03> 处理Source1
            09、处理Blocks
            10、根据前面执行的结果、决定如果操作
                01> 回到第02步
                02> 退出loop
            11、通知Observers：退出loop

         */


        /// timer添加到
        if #available(iOS 10.0, *) {
            let timer = Timer(timeInterval: 1, repeats: true) { timer in

            }
            RunLoop.current.add(timer, forMode: .common)
        } else {
            // Fallback on earlier versions
        }

    }


}
