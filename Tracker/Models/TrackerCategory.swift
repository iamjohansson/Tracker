import Foundation

struct TrackerCategory {
    let name: String
    let id: UUID
    
    init(name: String, id: UUID = UUID()) {
        self.name = name
        self.id = id
    }
}
