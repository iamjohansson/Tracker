import SnapshotTesting
import XCTest
@testable import Tracker

class TrackerViewControllerTests: XCTestCase {
    
    func testTrackerViewController() {
        let vc = TrackerViewController()
        
        assertSnapshot(of: vc, as: .image)
    }
}
