@testable import Tracker
import Foundation

final class TrackerTestStub: TrackerStoreProtocol {
    
    var trackersCount: Int = 2
    var numberOfSections: Int = 1
    var delegate: TrackerStoreDelegate?
    private let trackersBundle: [Tracker] = [
            Tracker(
                name: "Жесткий кодинг",
                color: .trackerColors[0],
                emoji: "🏓",
                sked: [.monday, .tuesday, .wednesday, .thursday, .friday],
                daysCount: 150
            )
        ]
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return 1
    }
    
    func object(at indexPath: IndexPath) -> Tracker? {
        let trackers = trackersBundle[indexPath.row]
        return trackers
    }
    
    func addTracker(tracker: Tracker, category: TrackerCategory) throws {
    }
    
    func headerInSection(_ section: Int) -> String? {
        return "Веселье"
    }
    
    func currentlyTrackers(date: Date, searchString: String) throws {
    }
    
    
}
