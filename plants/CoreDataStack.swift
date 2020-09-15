//
//  CoreDataStack.swift
//  plants
//
//  Created by Mark Kim on 9/10/20.
//  Copyright © 2020 Adriana González Martínez. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    
    // property to stroe the modelName
    private let modelName: String
    
    init(modelName: String) {
        self.modelName = modelName
    }
    
    // will always need this for CoreData to work
    lazy var managedContext: NSManagedObjectContext = {
        return self.storeContainer.viewContext
    }()
    
    private lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.modelName)
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                print("Error: \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    func saveContext() {
        guard managedContext.hasChanges else { return }
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Error: \(error), \(error.userInfo)")
        }
    }
}
