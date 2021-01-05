import Foundation

public extension Array {
    /// 数组去重
    func bee_filter<E: Equatable>(_ repeated: (Element) -> E) -> [Element] {
        var result = [Element]()
        self.forEach { (e) in
            let key = repeated(e)
            let keys = result.map{repeated($0)}
            guard !keys.contains(key) else {return}
            result.append(e)
        }
        return result
    }
}
