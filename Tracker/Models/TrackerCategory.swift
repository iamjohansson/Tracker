import Foundation

struct TrackerCategory {
    let name: String
    let trackersArray: [Tracker]
}

extension TrackerCategory {
    static let defaultValue: [TrackerCategory] =
    [
        TrackerCategory(name: "Важное", trackersArray: [])
    ]
}
