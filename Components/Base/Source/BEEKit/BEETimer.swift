import Foundation
import SwifterSwift

public protocol TimeProtocol {
    func time(withModel model:Time.Model, id:String)
}

public class Time {
    public static let shared: Time = Time()

    public static func remove(_ id: String) {
        Time.shared.timers.removeValue(forKey: id)
    }

    /// 时间倒计时标识存储 - 区别每个计时队列
    private var timers:[String:Time.Timer] = [:]
    private init(){}
}

extension Time {
    /// 计时器
    public class Timer {
        private init() {}
        private var timer: DispatchSourceTimer?
        /// 初始化一个计时器 handler: () -> Bool:是否停止  mainThread:主线程操作
        public init(id: String,
                    repeatSecond: Double,
                    handler: @escaping (() -> Bool),
                    mainThread: @escaping (() -> Void),
                    qos: DispatchQoS = .default) {
            let queue = DispatchQueue(label: id, qos:qos)
            self.timer = DispatchSource.makeTimerSource(queue:queue)
            self.timer?.schedule(wallDeadline:.now(), repeating: .milliseconds(Int(repeatSecond*1000)), leeway: .milliseconds(10))
            self.timer?.setEventHandler { [weak self] in
                //print(tv)
                if handler() {
                    self?.timer?.cancel()
                    self?.timer = nil
                }
                DispatchQueue.main.async(execute: mainThread)
            }
            self.timer?.resume()
        }
    }
    /// 回调类型
    public enum Style {
        case delegate(_ d:TimeProtocol, _ tag:String, _ remainTime:TimeInterval, _ repeatSecond:Double)
        case notification(_ tag:String, _ remainTime:TimeInterval, _ repeatSecond:Double)
        case callBack( _ tag:String, _ remainTime:TimeInterval, _ repeatSecond:Double, _ block:((Time.Model)->Void))
    }
    
    /// 计时模型
    public class Model {
        public var year: Int = 0
        public var month: Int = 0
        public var day: Int = 0
        public var hour: Int = 0
        public var minute: Int = 0
        public var second: Int = 0
        public var millisecond: Int = 0
        
        /// 剩余时间
        public var remainTime:TimeInterval = 0
    }
}


public extension Time {
    class func make(id:String,
                    remainTime:TimeInterval,
                    repeatSecond:Double,
                    mainThread block:@escaping ((Time.Model) -> Void),
                    qos:DispatchQoS = .default){
        guard !Time.shared.timers.keys.contains(id) else {return}
        /// 当前时间
        let endTime = Date.now().timeIntervalSince1970 + remainTime
        let endDate = Date(timeIntervalSince1970: endTime)
        let time = Time.Model()
        time.remainTime = endTime
        Time.shared.timers[id] = Time.Timer(id: id, repeatSecond: repeatSecond, handler: { () -> Bool in
            /// 当前时间 与 结束时间间隔 即剩余时间
            let nowDate2 = Date.now()
            let nowTime2 = nowDate2.timeIntervalSince1970
            let interval = endTime - nowTime2
            if interval <= 0 {
                time.year = 0
                time.month = 0
                time.day = 0
                time.hour = 0
                time.minute = 0
                time.second = 0
                time.millisecond = 0
                time.remainTime = 0
                Time.shared.timers.removeValue(forKey: id)
            }else{
                let coms = nowDate2.interval(endDate)
                time.year = coms.year ?? 0
                time.month = coms.month ?? 0
                time.day = coms.day ?? 0
                time.hour = coms.hour ?? 0
                time.minute = coms.minute ?? 0
                time.second = coms.second ?? 0
                time.millisecond = Int((interval - TimeInterval(Int(endTime - nowTime2))) * 1000.0)
                time.remainTime = interval
            }
            return interval <= 0
        }, mainThread: {
            block(time)
        }, qos:qos)
    }
}
public extension Time {
    /// 创建计时器
    class func make(_ style:Time.Style, qos:DispatchQoS = .default) {
        switch style {
        case let .delegate(d, id, time, second):
            Time.make(id: id, remainTime: time, repeatSecond: second, mainThread: { (model) in
                d.time(withModel: model, id:id)
            }, qos: qos)
        case let .notification(id, time, second):
            Time.make(id: id, remainTime: time, repeatSecond: second, mainThread: { (model) in
                NotificationCenter.default.post(name: Notification.Name(id), object: id, userInfo: [id:model])
            }, qos: qos)
        case let .callBack(id, time, second, block):
            Time.make(id: id, remainTime: time, repeatSecond: second, mainThread: block, qos: qos)
        }
    }
}
public extension Time {
    /// 剩余时间转换 - *提供一个参照样例*
    class func remainTime<T>(_ time: T) -> TimeInterval {
        switch time {
        case let t as String:
            guard let t = t.date else {
                return 0
            }
            return t.unixTimestamp - Date.now().unixTimestamp
        case let t as (String, String):
            guard let date = t.0.date(withFormat: t.1) else{
                return 0
            }
            return date.timeIntervalSince1970 - Date.now().timeIntervalSince1970
        case let t as Date:
            return t.unixTimestamp - Date.now().unixTimestamp
        default:
            return 0
        }
    }
}

//MARK:--- 延时执行 ----------


public extension Time {
    /// 如果时间大于 30 建议使用 Time.make
    class func delay(_ time: TimeInterval, _ block: @escaping (() -> Void)){
        DispatchQueue.main.asyncAfter(deadline: .now() + time, execute: block)
    }
}
