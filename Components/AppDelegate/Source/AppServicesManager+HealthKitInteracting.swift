import UIKit

extension ApplicationDelegate {

    @available(iOS 9.0, *)
    open func applicationShouldRequestHealthAuthorization(_ application: UIApplication) {
        for service in _services {
            service.applicationShouldRequestHealthAuthorization?(application)
        }
    }
}
