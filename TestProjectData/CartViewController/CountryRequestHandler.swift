//
// TestProjectData
//
//  Created by shashank atray on 14/10/20.
//  Copyright © 2020 shashank atray. All rights reserved.
//  Copyright © 2020 shashank atray. All rights reserved.
//

import Foundation
import CoreData
import UIKit

public protocol CountryRequestHandlerUseCase {
    func coreDataFetch(entityName: String, completionHandler: @escaping(_ result: [NSManagedObject]) -> ())
    func requestForCountryWith(requestUrl: URL, completionHandler: @escaping(_ result: TestPackage) -> ())
    func deleteAllCoreDataValues(entityName: String)
    
}

extension CountryRequestHandlerUseCase {
    
    public func coreDataFetch(entityName: String, completionHandler: @escaping(_ result: [NSManagedObject]) -> ()) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            if let data = result as? [NSManagedObject] {
                completionHandler(data)
            }
            
        } catch {
            print("Failed")
        }
    }
    
   public func deleteAllCoreDataValues(entityName: String) {
           let appDelegate = UIApplication.shared.delegate as! AppDelegate
           let context = appDelegate.persistentContainer.viewContext
           let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
           let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
           do {
               try context.execute(deleteRequest)
               try context.save()
           }
           catch {
               print ("There was an error")
           }
       }

    public func requestForCountryWith(requestUrl: URL, completionHandler: @escaping(_ result: TestPackage) -> ()) {
            
            let task = URLSession.shared.dataTask(with: requestUrl) { (data, response, error) in
                guard let data = data, error == nil else {
                    return
                }
               do {
                    let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                    if let json = responseJSON as? [Any], let compatData = json.first {
                        let jsonDataValue = try! JSONSerialization.data(withJSONObject: compatData, options: [])
                        let jsonString = String(data: jsonDataValue, encoding: .utf8)!
                        let jsonData = jsonString.data(using: .utf8)!
                        let testPackage = try JSONDecoder().decode(TestPackage.self, from: jsonData)
                        completionHandler(testPackage)
                    }
                  
                    
                } catch {
                    print("can not wrap json", error)
                }
            }
            task.resume()
        }
    
}

public struct CountryRequestHandler: CountryRequestHandlerUseCase {
    public init() {}
}
