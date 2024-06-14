//
//  ViewController.swift
//  10_04_24_CoreDataDemo
//
//  Created by Vishal Jagtap on 14/06/24.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //insertUserData()
        print("----retrive records----")
        retriveRecords()
        print("----delete records----")
        deleteRecord()
        print("----retrive records----")
        retriveRecords()
    }
    
    func insertUserData(){
       let appDelegate = UIApplication.shared.delegate as! AppDelegate
       let managedContext = appDelegate.persistentContainer.viewContext
        
       let userEntity = NSEntityDescription.entity(
            forEntityName: "User",
            in: managedContext)
        
      let userObject = NSManagedObject(entity: userEntity!, insertInto: managedContext)
        
        userObject.setValue("Ashwini", forKey: "name")
        userObject.setValue("Ashwini@gmail.com", forKey: "email")
        
        for i in 1...3{
            var userObj = NSManagedObject(entity: userEntity!, insertInto: managedContext)
            userObj.setValue("User\(i)", forKey: "name")
            userObj.setValue("user\(i)@gmail.com", forKey: "email")
        }
        
        do{
            try managedContext.save()
        }catch{
            print(error)
        }
    }
    
    func retriveRecords(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
        do{
            let fetchedResults = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            for eachRecord in fetchedResults{
                print("object id -- \(eachRecord.objectID) -- \(eachRecord.value(forKey: "name")!) -- \(eachRecord.value(forKey: "email")!)")
                //type cast the values on the basis of keys
                do{
                    try managedContext.save()
                }catch{
                    print(error.localizedDescription)
                }
            }
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func deleteRecord(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
        fetchRequest.predicate = NSPredicate(format: "name = %@", "Ashwini")
        do{
            let fetchedResults = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            
            for i in 0...fetchedResults.count - 1{
                let objectsToBeDeleted = fetchedResults[i] as! NSManagedObject
                managedContext.delete(objectsToBeDeleted)
            }
            
            do{
                try managedContext.save()
            }catch{
                print(error.localizedDescription)
            }
            
        } catch {
            print(error.localizedDescription)
        }
    }
}
