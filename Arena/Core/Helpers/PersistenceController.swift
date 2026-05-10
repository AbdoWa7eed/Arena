//
//  PersistenceController.swift
//  Arena
//
//  Created by Abdelrahman on 10/05/2026.
//

import Foundation
import CoreData

final class PersistenceController {

    static let shared = PersistenceController()

    static let containerName = "Arena"

    private let container: NSPersistentContainer

    private init() {

        container = NSPersistentContainer(name: Self.containerName)

        container.loadPersistentStores { _, error in

            if let error = error {
                fatalError("Core Data failed: \(error)")
            }
        }

        container.viewContext.mergePolicy =
            NSMergeByPropertyObjectTrumpMergePolicy
    }

    private var context: NSManagedObjectContext {
        container.viewContext
    }

    func save() {
        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch {
            print("Failed saving context: \(error)")
        }
    }

    func create<T: NSManagedObject>(
        _ type: T.Type
    ) -> T {
        T(context: context)
    }

    func fetch<T: NSManagedObject>(
        request: NSFetchRequest<T>
    ) -> [T] {
        do {
            return try context.fetch(request)
        } catch {
            print("Failed fetching \(T.self): \(error)")
            return []
        }
    }

    func find<T: NSManagedObject>(
        request: NSFetchRequest<T>
    ) -> T? {
        do {
            return try context.fetch(request).first
        } catch {
            print("Failed finding \(T.self): \(error)")
            return nil
        }
    }

    func delete(_ object: NSManagedObject) {
        context.delete(object)
    }
}
