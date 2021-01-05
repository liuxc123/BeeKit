import Foundation
import UIKit

public extension UIViewController{
    enum UIViewControllerError:Error {
        case noBundle
    }
    static func bee_storyboard(_ name:String = "Main", id:String = "") -> UIViewController {
        let identifier = id == "" ? String(describing: self) : id
        return UIStoryboard(name: name, bundle: nil).instantiateViewController(withIdentifier: identifier)
    }
    
    /// - from:bundle.url(forResource (s.resource_bundles -> key) ; name:storyboard name
    static func bee_storyboard(_ name:String, id:String = "", from:String? = nil) -> UIViewController? {
        let identifier = id.isEmpty ? String(describing: self) : id
        let storyboard = UIStoryboard(name: name, bundle: Bundle.bee_bundle(self, from) ?? Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: identifier)
    }
}
