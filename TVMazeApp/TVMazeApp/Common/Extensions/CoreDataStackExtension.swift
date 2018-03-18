//
//  CoreDataStackExtension.swift
//  TVMazeApp
//
//  Created by Anne Kariny Silva Freitas on 17/03/2018.
//  Copyright © 2018 Anne Kariny Silva Freitas. All rights reserved.
//

import Foundation
import CoreData

extension CoreDataStack {
    
    private static func show(fromShowDB showDB: ShowDB) -> Show {
        let derivedShow = Show(id:Int(showDB.id),
                               name: showDB.name ?? "",
                               imageUrl: showDB.imageUrl ?? "",
                               time: showDB.time ?? "",
                               days: showDB.days as? [String] ?? [],
                               genres: showDB.genres as? [String] ?? [],
                               summary: showDB.summary ?? "")
        
        return derivedShow
    }
    
    private static func showDB(fromShow show: Show) -> ShowDB {
        let showForDB = ShowDB(context: context)
        
        showForDB.id = Int64(show.id)
        showForDB.name = show.name
        showForDB.imageUrl = show.imageUrl
        showForDB.time = show.time
        showForDB.days = show.days as NSObject?
        showForDB.genres = show.genres as NSObject?
        
        return showForDB
    }
    
    // MARK: - Read
    static func read() -> [Show]? {
        let fetchRequest: NSFetchRequest<ShowDB> = ShowDB.fetchRequest()
        fetchRequest.relationshipKeyPathsForPrefetching = ["manySeasons"]
        
        do {
            let result = try context.fetch(fetchRequest)
            return result.map { show(fromShowDB: $0) }
        } catch {
            return nil
        }
    }
    
    static func read(withId id: Int) -> Show? {
        let fetchRequest: NSFetchRequest<ShowDB> = ShowDB.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == \(id)")
        fetchRequest.relationshipKeyPathsForPrefetching = ["manySeasons"]
        
        do {
            let result = try context.fetch(fetchRequest)
            if let showDB = result.first {
                return show(fromShowDB: showDB)
            } else {
                return nil
            }
        } catch {
            return nil
        }
    }
    
    // MARK: - Save
    static func save(_ show: Show) {
        var existsOnDB = false
        if let savedShows = CoreDataStack.read() {
            for savedShows in savedShows {
                if savedShows.id == show.id {
                    existsOnDB = true
                }
            }
        }
        if !existsOnDB {
            _ = showDB(fromShow: show)
            saveContext()
        }
    }
    
    // MARK: - Delete
    static func delete(withId id: Int) {
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "ShowDB")
        deleteFetch.predicate = NSPredicate(format: "id == \(id)")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print ("There was an error")
        }
    }
    
}
