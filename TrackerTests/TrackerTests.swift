import XCTest
import SnapshotTesting
@testable import Tracker

final class TrackerTests: XCTestCase {
        
    func testTrackerViewControllerLight() {
        let trackerStore = TrackerTestStub()
        let vc = TrackerViewController(trackerStore: trackerStore)
        
        let record = false
        assertSnapshot(of: vc, as: .image(traits: UITraitCollection(userInterfaceStyle: .light)), record: record)
    }
    
    func testTrackerViewControllerDark() {
        let trackerStore = TrackerTestStub()
        let vc = TrackerViewController(trackerStore: trackerStore)
        
        let record = false
        assertSnapshot(of: vc, as: .image(traits: UITraitCollection(userInterfaceStyle: .dark)), record: record)
    }
}

