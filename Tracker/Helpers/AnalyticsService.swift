import Foundation
import YandexMobileMetrica

// MARK: - Yandex Analytics Service
struct AnalyticsService {
    static func appDelegateSetup() {
        guard let configuration = YMMYandexMetricaConfiguration(apiKey: "21dba8f7-b984-43d8-b749-4bbdc5c9e931") else {
            return
        }
        YMMYandexMetrica.activate(with: configuration)
    }
    
    func report(event: Events, parameters: [AnyHashable : Any]) {
        YMMYandexMetrica.reportEvent(event.rawValue, parameters: parameters) { error in
            print("REPORT ERROR: %@", error.localizedDescription)
        }
    }
}

// MARK: Extension - AnalyticsService
extension AnalyticsService {
    
    func didApper() {
        report(event: .open, parameters: ["screen" : "Main"])
    }
    
    func didDisappear() {
        report(event: .close, parameters: ["screen" : "Main"])
    }
    
    func tapPlusButton() {
        report(event: .click, parameters: ["screen" : "Main", "item" : Items.add_track.rawValue])
    }
    
    func tapFilterButton() {
        report(event: .click, parameters: ["screen" : "Main", "item" : Items.filter.rawValue])
    }
    
    func editTracker() {
        report(event: .click, parameters: ["screen" : "Main", "item" : Items.edit.rawValue])
    }
    
    func deleteTracker() {
        report(event: .click, parameters: ["screen" : "Main", "item" : Items.delete.rawValue])
    }
    
    func tapTrackerDayButton() {
        report(event: .click, parameters: ["screen" : "Main", "item" : Items.track.rawValue])
    }
}

// MARK: - Enum case
enum Events: String, CaseIterable {
    case open = "open"
    case close = "close"
    case click = "click"
}

enum Items: String, CaseIterable {
    case add_track = "add_track"
    case track = "track"
    case filter = "filter"
    case edit = "edit"
    case delete = "delete"
}
