//
//  CoreDataManager.swift
//  Todo
//
//  Created by mani on 2020-04-27.
//  Copyright © 2020 mani. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    let modelName: String
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.modelName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                fatalError("Unresolved error \(error)")
            }
        })
        return container
    }()
    lazy var managedObjectContext: NSManagedObjectContext = {
        return self.persistentContainer.viewContext
    }()

    init(modelName: String) {
        self.modelName = modelName
    }
}
