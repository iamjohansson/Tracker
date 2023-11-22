import CoreData
import UIKit

final class TrackerCategoryStore: NSObject {
    
    // MARK: - Properties
    var category = [TrackerCategory]()
    private let context: NSManagedObjectContext
    
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
    
    func takeCategory(with id: UUID) throws -> TrackerCategoryCoreData {
        let request = NSFetchRequest<TrackerCategoryCoreData>(entityName: "TrackerCategoryCoreData")
        request.predicate = NSPredicate(
            format: "%K == %@",
            (\TrackerCategoryCoreData.id)._kvcKeyPathString!, id.uuidString)
        let category = try context.fetch(request)
        return category[0]
    }
    
    private func createCategoryForTrackers(from data: TrackerCategoryCoreData) throws -> TrackerCategory {
        guard let name = data.name,
              let id = data.categoryId else { throw TrackerError.decodeError }
        return TrackerCategory(name: name, id: id)
    }
    
    private func setupCategory(with context: NSManagedObjectContext) throws {
        let fetchResult = try context.fetch(TrackerCategoryCoreData.fetchRequest())
        guard fetchResult.isEmpty else {
               category = try fetchResult.map({ try createCategoryForTrackers(from: $0) })
               return
           }
        let categories = [
            TrackerCategory(name: "Важное"),
            TrackerCategory(name: "Средней важности")
        ]
        
        let categoriesCoreData = categories.map { category in
            let cd = TrackerCategoryCoreData(context: context)
            cd.categoryId = category.id
            cd.name = category.name
            return cd
        }
        try context.save()
    }
}
