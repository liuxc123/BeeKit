
    import Foundation
    import UIKit
    import BeeKit

    public enum BEEIconFont {
        class Help {}
    
        case tarrow_right(_ size:CGFloat)
        case tbrowse(_ size:CGFloat)
        case tbottom(_ size:CGFloat)
        case tback(_ size:CGFloat)
        case tbad(_ size:CGFloat)
        case tarrow_double_left(_ size:CGFloat)
        case tarrow_left_circle(_ size:CGFloat)
        case tarrow_double_right(_ size:CGFloat)
        case tcaps_lock(_ size:CGFloat)
    }
    
    extension BEEIconFont: IconFontProtocol {
        public var font:UIFont {
            return UIFont.iconFont("iconfont", size: self.size, forClass: BEEIconFont.Help.self, from: "")
        }
        
        public var size: CGFloat {
            switch self {
            case .tarrow_right(let size),
            .tbrowse(let size),
            .tbottom(let size),
            .tback(let size),
            .tbad(let size),
            .tarrow_double_left(let size),
            .tarrow_left_circle(let size),
            .tarrow_double_right(let size),
            .tcaps_lock(let size):
                return size
            }
        }
                    
        public var text: String {
            switch self { 
            case .tarrow_right:
                return ""  
            case .tbrowse:
                return ""  
            case .tbottom:
                return ""  
            case .tback:
                return ""  
            case .tbad:
                return ""  
            case .tarrow_double_left:
                return ""  
            case .tarrow_left_circle:
                return ""  
            case .tarrow_double_right:
                return ""  
            case .tcaps_lock:
                return "" 
            }
        }
    }
    
