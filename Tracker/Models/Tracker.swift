import UIKit

struct Tracker {
    let id: UUID
    let name: String
    let color: UIColor
    let emoji: String
    let sked: [WeekDays]
}

extension Tracker {
    struct Track {
        var name: String = ""
        var color: UIColor? = nil
        var emoji: String? = nil
        var sked: [WeekDays]? = nil
    }
}
