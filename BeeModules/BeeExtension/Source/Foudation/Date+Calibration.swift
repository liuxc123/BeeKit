import Foundation

// MARK: - 时间校验

extension Date {

    /// 服务器时间
    public static var serverTime: Int {
        set {
            UserDefaults.standard.set(newValue, forKey: "server_time_key")
            Date.runtime0 = Date.current() - Date.boottime()
        }
        get { return UserDefaults.standard.integer(forKey: "server_time_key") }
    }

    /// 校准过后时间 如果没有服务器时间 返回系统时间
    public static func now() -> Date {
        if Date.serverTime == 0 {
            return Date()
        }
        // 当前时刻设备运行时间
        let runTime1 = Date.current() - Date.boottime()
        let currentTime = Date.serverTime + (runTime1 - Date.runtime0)
        return Date(timeIntervalSince1970: TimeInterval(currentTime))
    }

    /// 获取当前 Unix Time
    private static func current() -> Int {
        var now = timeval()
        var tz = timezone()
        gettimeofday(&now, &tz)
        return now.tv_sec
    }

    /// 获取到服务器时间的 当前设备运行时间
    private static var runtime0: Int {
        set { UserDefaults.standard.set(newValue, forKey: "server_runtime_key") }
        get { return UserDefaults.standard.integer(forKey: "server_runtime_key") }
    }

    /// 获取设备上次重启的 Unix Time
    private static func boottime() -> Int {
        var mid = [CTL_KERN, KERN_BOOTTIME]
        var boottime = timeval()
        var size = MemoryLayout.size(ofValue: boottime)

        if sysctl(&mid, 2, &boottime, &size, nil, 0) != -1 {
            return boottime.tv_sec
        }
        return 0
    }
}
