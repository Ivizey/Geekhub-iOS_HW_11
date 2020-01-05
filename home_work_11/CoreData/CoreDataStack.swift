//
//  CoreDataStack.swift
//  home_work_11
//
//  Created by Pavel Bondar on 03.01.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import CoreData

class CoreDataStack {

    static let shared = CoreDataStack()

    private init() { }

    private(set) lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "JournalModel")

        container.loadPersistentStores(completionHandler: { _, error in
                if let error = error {
                    debugPrint(error)
                    return
                }
                container.viewContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
        })
        return container
    }()

    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
