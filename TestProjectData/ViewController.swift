//
// TestProjectData
//
//  Created by shashank atray on 13/10/20.
//  Copyright © 2020 shashank atray. All rights reserved.
//  LinkeIn - https://www.linkedin.com/in/shashank-k-atray/
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    let navigator = ListNavigatorRouting()
    let requestHandler = GetDataRequestHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         navigationItem.title = "Home"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonClicked() {
        self.fetchCountrydata()
    }
    
    func fetchCountrydata() {
        let url = URL(string: "https://restcountries.eu/rest/v2/all")!
        requestHandler.requestForCountryListDataWith(requestUrl: url) { result in
    
            if let testData = result as? [TestPackage] {
                DispatchQueue.main.async { [unowned self] in
                    self.saveDataToCoreData(testData: testData)
                }
            }
        }
    }
        
        func saveDataToCoreData(testData: [TestPackage]) {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: "TestData", in: context)
            
            for index in 0...testData.count - 1 {
                let managedObject = NSManagedObject(entity: entity!, insertInto: context)
                managedObject.setValue(testData[index].name, forKey: "name")
                managedObject.setValue(testData[index].nativeName, forKey: "nativeName")
                managedObject.setValue(testData[index].gini, forKey: "gini")
                managedObject.setValue(testData[index].alpha2Code, forKey: "alpha2Code")
                managedObject.setValue(testData[index].alpha3Code, forKey: "alpha3Code")
                managedObject.setValue(testData[index].capital, forKey: "capital")
                managedObject.setValue(testData[index].area, forKey: "area")
                managedObject.setValue(testData[index].region, forKey: "region")
                
                do {
                    try context.save()
                } catch {
                    print("didnt save")
                }
                
            }
            self.gotToList()
        }
    
    func gotToList() {
        if let navController = self.navigationController {
            navigator.makeListViewController(from: navController)
        }
    }
        
}

