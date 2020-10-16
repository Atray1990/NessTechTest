//
//  TestProjectData
//
//  Created by shashank atray on 14/10/20.
//  Copyright © 2020 shashank atray. All rights reserved.
//  LinkeIn - https://www.linkedin.com/in/shashank-k-atray/
//

import Foundation
import UIKit
import CoreData


open class CartEventHandler {

weak var viewController: CountryViewController?
let navigator: CountryNavigatorRouting
let requestHandler: CountryRequestHandler?

init(viewController: CountryViewController, requestHandler: CountryRequestHandler , navigator: CountryNavigatorRouting) {
    self.viewController = viewController
    self.requestHandler = requestHandler
    self.navigator = navigator
}

    func getCountryData(country: String) {
        let demoUrl = "https://restcountries.eu/rest/v2/name/\(country)?fullText=true"
        let url = URL(string: demoUrl.removingCharacters(from: .whitespacesAndNewlines))!
        requestHandler?.requestForCountryWith(requestUrl: url, completionHandler: { result in
            DispatchQueue.main.async {
                if let resultData = result as? TestPackage {
                    print(resultData.regionalBlocs![0].acronym)
                    self.viewController?.setUpData(testData: resultData)
                }
            }
        })
    }
    
    func getCoreData() {
        requestHandler?.coreDataFetch(entityName: "TestData"){ result in   // call to request handle to return the data
            
            if !(result.isEmpty) {
             
            }
        }
    }
    

}
