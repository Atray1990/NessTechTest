//
//  TestPackageModal.swift
//  TestProjectData
//
//  Created by shashank atray on 13/10/20.
//  Copyright © 2020 shashank atray. All rights reserved.
//  LinkeIn - https://www.linkedin.com/in/shashank-k-atray/
//

import Foundation
import UIKit


public struct TestPackage : Decodable  {
    
    let name: String
    let gini: Double?
    let alpha2Code: String
    let alpha3Code: String
    let callingCodes: [String]?
    let altSpellings: [String]?
    let capital: String?
    let region: String?
    let subregion: String?
    let latlng: [Double]?
    let area: Double?
    let timezones: [String]?
    let borders:  [String]?
    let nativeName: String?
    let flag: String?
    let regionalBlocs: [RegionalBlocks]?
    let currencies:[currencies]?
    let population: Int?
    
    // making not necessary values as optional as some data modal doesnt have them plus want to use same modal for core data
    
}

public struct RegionalBlocks : Decodable {
    let acronym: String?
    let name: String?
}

public struct currencies: Decodable {
    let code: String?
    let name: String?
}
