//
//  ListViewEventHandler.swift
//  TestProjectData
//
//  Created by shashank atray on 13/10/20.
//  Copyright © 2020 shashank atray. All rights reserved.
//  LinkeIn - https://www.linkedin.com/in/shashank-k-atray/
//

import Foundation
import UIKit
import CoreData

open class ListViewEventHandler {
    
    weak var viewController: ListViewController?
    let navigator: ListNavigatorRouting
    let requestHandler: GetDataRequestHandler
    
    init(viewController: ListViewController, requestHandler: GetDataRequestHandler, navigator: ListNavigatorRouting) {
        self.viewController = viewController
        self.requestHandler = requestHandler
        self.navigator = navigator
    }
    
    func fetchdata() {
        let url = URL(string: "https://restcountries.eu/rest/v2/all")!
        requestHandler.requestForCountryListDataWith(requestUrl: url) { result in
            
            if !(result.isEmpty) {
                self.viewController?.showTestData(testData: result)
                self.viewController?.saveTestData(testData: result)
            }
        }
    }
    
    func moveToCountryScreen(navController: UINavigationController, selectedTest:TestPackage) {
        navigator.makeCartViewController(from: navController, selectedTest: selectedTest)
    }
    
    func searchThroughData(testData: [TestPackage], searchString: String){
        var search: [TestPackage] = []
        for index in 0..<testData.count {
            if let keyWord = testData[index].name as? String, keyWord.contains(searchString) {
                search.append(testData[index])
            }
        }
        self.viewController?.selectedTestPackage = search
        self.viewController?.showTestData(testData: search)
    }
    
   
    
    func getCoreData() {
        requestHandler.coreDataFetch(entityName: "TestData"){ result in   // call to request handle to return the data
               
               if !(result.isEmpty) {
                   let testData = self.handleDataFromCoreData(testData:result )
                    self.viewController?.showTestData(testData:testData )
                    self.viewController?.saveTestData(testData: testData)
               }
           }
       }
       
    func handleDataFromCoreData(testData: [NSManagedObject]) -> [TestPackage] {
        
        // binding core data to pre-exiting modal and reusing the modal
        let testPackage: [TestPackage] = testData.map { testDataDict in
            
            let name = testDataDict.value(forKey: "name") as? String ?? ""
            let nativeName = testDataDict.value(forKey: "nativeName") as? String ?? ""
            let gini = testDataDict.value(forKey: "gini") as? Double ?? 0
            let alpha2Code = testDataDict.value(forKey: "alpha2Code") as? String ?? ""
            let capital = testDataDict.value(forKey: "capital") as? String ?? ""
            let alpha3Code = testDataDict.value(forKey: "alpha3Code") as? String ?? ""
            let area = testDataDict.value(forKey: "area") as? Double ?? 0
            let region = testDataDict.value(forKey: "region") as? String ?? ""
            
            let testPackage = TestPackage.init(name: name , gini: gini, alpha2Code: alpha2Code, alpha3Code: alpha3Code, callingCodes: nil, altSpellings: nil, capital: capital, region: region, subregion: nil, latlng: nil, area: area, timezones: nil, borders: nil, nativeName: nativeName,flag: nil, regionalBlocs: nil, currencies: nil, population: nil)
            return testPackage
        }
        return testPackage
    }
    
}
