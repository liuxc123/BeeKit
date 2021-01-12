import Foundation
import UIKit

/// BEEKit version string.
public let BEEKitVersion = "1.0.0"

/// Font typealias.
public typealias Font = UIFont
/// Color typealias.
public typealias Color = UIColor

/// BEEKit errors enum.
///
/// - jsonSerialization: JSONSerialization error.
/// - errorLoadingSound: Could not load sound error.
/// - pathNotExist: Path not exist error.
/// - pathNotAllowed: Path not allowed error.
public enum BEEKitError: Error {
    case jsonSerialization
    case errorLoadingSound
    case pathNotExist
    case pathNotAllowed
}

