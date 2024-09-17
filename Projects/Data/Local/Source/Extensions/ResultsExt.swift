import Foundation
import RealmSwift

extension Results {
    func toArray() -> [Element] {
        return Array(self)
    }
    func toArray<T>(type: T.Type) -> [T] {
        return compactMap { $0 as? T }
    }
}
