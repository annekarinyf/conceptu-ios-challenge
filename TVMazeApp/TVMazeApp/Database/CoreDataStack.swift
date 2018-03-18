//
//  CoreDataStack.swift
//  TVMazeApp
//
//  Created by Anne Kariny Silva Freitas on 17/03/2018.
//  Copyright © 2018 Anne Kariny Silva Freitas. All rights reserved.
//

import Foundation

import CoreData

enum LogicOperator: String {
    case and = "AND"
    case or = "OR"
}

class CoreDataStack {
    
    static var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TVMazeApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Saving
    static func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    // MARK: - Deleting
    static func delete (object: NSManagedObject) {
        context.delete(object)
    }
    
    static func delete(forEntityName entityName: String) {
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print ("There was an error")
        }
    }
}

