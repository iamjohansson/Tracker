import UIKit
import CoreData

protocol TrackerStoreDelegate: AnyObject {
    func didUpdate()
}

protocol TrackerStoreProtocol {
    var numberOfSections: Int { get }
    func numberOfRowsInSection(_ section: Int) -> Int
    func object(at indexPath: IndexPath) -> Tracker?
    func addTracker(tracker: Tracker, category: TrackerCategory) throws
    func headerInSection(_ section: Int) -> String?
}

final class TrackerStore: NSObject, NSFetchedResultsControllerDelegate {
    
    // MARK: - Properties
    weak var delegate: TrackerStoreDelegate?
    private let context: NSManagedObjectContext
    
    private lazy var fetchedResultsController: NSFetchedResultsController<TrackerCoreData> = {
        let fetchRequest = NSFetchRequest<TrackerCoreData>(entityName: "TrackerCoreData")
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \TrackerCoreData.category?.categoryId, ascending: true)]
        let fetchedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: context,
            sectionNameKeyPath: "category",
            cacheName: nil)
        fetchedResultsController.delegate = self
        try? fetchedResultsController.performFetch()
        return fetchedResultsController
    }()
    
    // MARK: - Initializers
    convenience override init() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        self.init(context: context)
    }
    
    init(context: NSManagedObjectContext) {
        self.context = context
        super.init()
    }
    
    // MARK: - Methods
    func createTracker(from tracker: TrackerCoreData) throws -> Tracker {
        guard
            let id = tracker.id,
            let name = tracker.name,
            let emoji = tracker.emoji,
            let color = tracker.color,
            let sked = WeekDays.reversTransformedSked(value: tracker.sked)
        else { throw TrackerError.decodeError }
        return Tracker(id: id, name: name, color: color as! UIColor, emoji: emoji, sked: sked)
    }
    
    func currentlyTrackers(date: Date, searchString: String) throws {
        
        let day = Calendar.current.component(.weekday, from: date)
        let weekdayIndex = day > 1 ? day - 2 : day + 5
        let matching = (0..<7).map { $0 == weekdayIndex ? "+" : "-" }
        
        var predicates = [NSPredicate]()
        predicates.append(NSPredicate(
            format: "%K == nil OR (%K !=nil AND %K MATCHES[c] %@)",
            #keyPath(TrackerCoreData.sked),
            #keyPath(TrackerCoreData.sked),
            #keyPath(TrackerCoreData.sked), matching
        ))
        
        if !searchString.isEmpty {
            predicates.append(NSPredicate(
                format: "%K CONTAINS[cdx] %@",
                #keyPath(TrackerCoreData.name), searchString
            ))
            
            fetchedResultsController.fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
            try? fetchedResultsController.performFetch()
            delegate?.didUpdate()
        }
    }
    
    func takeTracker(for id: UUID) throws -> TrackerCoreData? {
        fetchedResultsController.fetchRequest.predicate = NSPredicate(
            format: "%K CONTAINS %@",
            (\TrackerCoreData.id)._kvcKeyPathString!, id.uuidString
        )
        try fetchedResultsController.performFetch()
        return fetchedResultsController.fetchedObjects?.first
    }
    
//    private func convertColorToData(_ color: UIColor) -> NSData? {
//        do {
//            return try NSKeyedArchiver.archivedData(
//                withRootObject: color,
//                requiringSecureCoding: false
//            ) as NSData
//        } catch {
//            print("Ошибка при конвертировании цвета в Data: \(TrackerError.decodeError)")
//            return nil
//        }
//    }
//    
//    private func convertDataToColor(_ data: NSData) -> UIColor? {
//        do {
//            if let color = try NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: data as Data) {
//                return color
//            }
//        } catch {
//            print("Ошибка при конвертировании Data в цвет: \(TrackerError.decodeError)")
//            return nil
//        }
//    }
    
    // MARK: - FetchResultDelegate
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        delegate?.didUpdate()
    }
}

// MARK: - Extension TrackerStoreProtocol
extension TrackerStore: TrackerStoreProtocol {
    var numberOfSections: Int {
        fetchedResultsController.sections?.count ?? 0
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    func object(at indexPath: IndexPath) -> Tracker? {
        let cd = fetchedResultsController.object(at: indexPath)
        return try? createTracker(from: cd)
    }
    
    func addTracker(tracker: Tracker, category: TrackerCategory) throws {
        let trackerData = TrackerCoreData(context: context)
        trackerData.id = tracker.id
        trackerData.name = tracker.name
        trackerData.emoji = tracker.emoji
        trackerData.color = tracker.color
        trackerData.sked = WeekDays.transformedSked(value: tracker.sked)
        // По идее, нужно передавать и категорию
        try context.save()
    }
    
    func headerInSection(_ section: Int) -> String? {
        guard let cd = fetchedResultsController.sections?[section].objects?.first
                as? TrackerCoreData else { return nil }
        return cd.category?.name ?? nil
    }
    
}

// MARK: - ErrorCaseForStore
enum TrackerError: Error {
    case decodeError
}
