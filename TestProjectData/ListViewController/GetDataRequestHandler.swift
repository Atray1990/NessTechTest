//
//  GetDataRequestHandler.swift
//  TestProjectData
//
//  Created by shashank atray on 13/10/20.
//  Copyright © 2020 shashank atray. All rights reserved.
//  LinkeIn - https://www.linkedin.com/in/shashank-k-atray/
//

import Foundation

public protocol GetDataRequestHandlerUseCase {
    func requestForCountryListDataWith(requestUrl: URL, completionHandler: @escaping(_ result: [TestPackage]) -> ())}

extension GetDataRequestHandlerUseCase {
    
    public func requestForCountryListDataWith(requestUrl: URL, completionHandler: @escaping(_ result: [TestPackage]) -> ()) {
        
        let task = URLSession.shared.dataTask(with: requestUrl) { (data, response, error) in
            guard let data = data, error == nil else {
                return
            }
           do {
                let jsonString = String(data: data, encoding: .utf8)!
                let jsonData = jsonString.data(using: .utf8)!
                let testPackage = try JSONDecoder().decode([TestPackage].self, from: jsonData)
                completionHandler(testPackage)
                
            } catch {
                print("can not wrap json", error)
            }
        }
        task.resume()
    }
}

public struct GetDataRequestHandler: GetDataRequestHandlerUseCase, CountryRequestHandlerUseCase {
    public init() {}
}
