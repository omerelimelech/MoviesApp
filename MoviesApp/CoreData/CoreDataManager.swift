//
//  CoreDataManager.swift
//
//
//  Created by Omer Elimelech on 29/01/2019.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import Foundation
import UIKit
import CoreData
enum error: Error {
    case myerror
}

typealias fetchResult<T: NSManagedObject> = Result<[T]?, Error>
typealias fetchComplation<T: NSManagedObject> = (_ result: fetchResult<T>) -> Bool

class CoreDataManager: NSObject {
    static let shared = CoreDataManager()

    enum Entities: String {
        case favoritesMovie = "FavoriteMovie"
    }
    
    weak var appDelegate: AppDelegate? = {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {return nil}
        return delegate
    }()

    private var managedContext: NSManagedObjectContext? {
        let context = appDelegate?.persistentContainer.viewContext
        context?.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return context
    }
    
    public func getEntity<T: NSManagedObject>(forType type: T.Type, entityName: Entities) -> T? {
        guard let managedContext = self.managedContext else {return nil}
        return T(context: managedContext)
    }
    
    func get<T: NSManagedObject>(type: T.Type, entityName: Entities, predicate: NSPredicate?, completion: @escaping fetchComplation<T>) -> Bool {
        let fetchRequest = NSFetchRequest<T>(entityName: entityName.rawValue)
        fetchRequest.predicate = predicate
        do {
            let objects = try (managedContext?.fetch(fetchRequest))
            return(completion(.success(objects)))
        } catch let error as NSError {
            return(completion(.failure(error)))
        }
    }
    
    func save<T: NSManagedObject>(entityName: Entities, object: T, completion: @escaping (_ success: Bool) -> Void) {
        guard let managedContext = self.managedContext else { return }
        managedContext.insert(object)
        completion(saveContext())
    }
    
    func delete<T: NSManagedObject>(object: T?, completion: @escaping (_ success: Bool) -> Void) {
        guard let managedContext = self.managedContext, let object = object else { return }
        managedContext.delete(object)
        completion(saveContext())
    }
    
    func saveContext() -> Bool {
        guard let context = self.managedContext else { return false }
         do {
            try context.save()
            return true
         } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            return false
        }
    }
}
