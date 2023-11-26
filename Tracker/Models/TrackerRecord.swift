import Foundation

struct TrackerRecord: Hashable {
    let id: UUID
    let date: Date
    let trackerId: UUID
    
    init(id: UUID = UUID(), date: Date, trackerId: UUID) {
        self.id = id
        self.date = date
        self.trackerId = trackerId
    }
}
