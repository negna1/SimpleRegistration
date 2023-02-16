//
//  UserCoreData.swift
//  PetProject
//
//  Created by Nato Egnatashvili on 15.02.23.
//

import Foundation
import CoreData
import UIKit

final class LocalUsersData: NSManagedObject {
    private var users: [NSManagedObject] = []
    private let managedContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    @NSManaged private var email: String?
    @NSManaged private var password: String?
    @NSManaged private var birtDate: Date?
    
    private var userValues: [User] {
        self.users.compactMap { obj in
            guard let email = obj.value(forKey: Constant.email) as? String,
                  let password = obj.value(forKey: Constant.password) as? String,
                  let birtDate = obj.value(forKey: Constant.birthDate) as? Date else { return nil}
            return User(email: email,
                        password: password,
                        birthDate: birtDate)
        }.compactMap({$0})
    }
}

//MARK: - Public functions -
extension LocalUsersData {
    public func fetchRequest() async -> [User]{
        guard let managedContext = managedContext else { return [] }
        let fetchRequest =
        NSFetchRequest<NSManagedObject>(entityName: Constant.entityName)
        
        do {
            users = try managedContext.fetch(fetchRequest)
            return userValues
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return []
        }
    }
    
    public func isUserExist(email: String, password: String) async -> Result<Bool, CoreDataError> {
        guard let managedContext = managedContext else { return .failure(.managedNotFound)}
        let myRequest =
        NSFetchRequest<NSManagedObject>(entityName: Constant.entityName)
        let predicate1 = NSPredicate(format: "email == %@", email)
        let predicate2 = NSPredicate(format:  "password == %@", password)
        let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [predicate1,predicate2])
        myRequest.predicate = predicateCompound
        do {
            let user = try managedContext.fetch(myRequest)
            if user.count == 1 {
                return .success(true)
            }
            return .success(false)
        } catch _ as NSError {
            return .failure(.managedNotFound)
        }
    }
    
    public func saveUser(object: User) async -> Result<Bool, CoreDataError> {
        guard let managedContext = managedContext else { return .failure(.managedNotFound)}
        let res = await isUserExist(email: object.email, password: object.password)
        switch res {
        case .success(let userExist):
            if userExist { return .failure(.UserExist)}
        case .failure(_):
            return .failure(.managedNotFound)
        }
        let entity =
        NSEntityDescription.entity(forEntityName: Constant.entityName,
                                   in: managedContext)!
        
        let user = NSManagedObject(entity: entity,
                                   insertInto: managedContext)
        user.setValue(object.email, forKeyPath: Constant.email)
        user.setValue(object.password, forKeyPath: Constant.password)
        user.setValue(object.birthDate, forKeyPath: Constant.birthDate)
        user.setValue(object.id, forKeyPath: Constant.id)
        do {
            try managedContext.save()
            users.append(user)
            return .success(true)
        } catch _ as NSError {
            return.failure(.NotSaved)
        }
    }
}

