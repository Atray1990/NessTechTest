//
//  CountryViewController.swift
//  TestProjectData
//
//  Created by shashank atray on 16/10/20.
//  Copyright © 2020 shashank atray. All rights reserved.
//

import UIKit

class CountryViewController: UIViewController {
    @IBOutlet weak var btnCapital:UIButton!
    @IBOutlet weak var lblRegion: UILabel!
    @IBOutlet weak var lblPopulation: UILabel!
    @IBOutlet weak var lblCurrency: UILabel!
    @IBOutlet weak var lblReligionalBloc: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    var testPackage: TestPackage?
    lazy var imageLoader = ImageLoader()
   
    var eventHandler: CartEventHandler!
    var isCoreDataNav:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        // Do any additional setup after loading the view.
    }
    
    func setUpViews() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(popBack))
        navigationItem.title = testPackage?.name
        getCoreDataValues()
    }
    
    func setUpData(testData: TestPackage) {
        if let testPackage = testData as? TestPackage {
            lblRegion.text = testPackage.region ?? ""
            if let capital = testPackage.capital as? String {
                btnCapital.setTitle(capital, for: .normal)
            }
            
            if let population = testPackage.population {
                lblPopulation.text = "\(population) crores"
            }
            lblCurrency.text = testPackage.currencies?.first?.name ?? ""
            lblReligionalBloc.text = testPackage.regionalBlocs?.first?.acronym ?? ""
            if let url = URL(string: testPackage.flag!) {
                imgView.downloadedsvg(from: url)
            }
        }
       
    }
    
    func getCoreDataValues() {
        if let testPac = testPackage, let countryName = testPac.name as? String {
             eventHandler.getCountryData(country: countryName)
        }
    }
    
    // MARK: - Navigation Here is the Api : https://5f1a8228610bde0016fd2a74.mockapi.io/getTestList
       @objc func popBack() {
           self.navigationController?.popViewController(animated: true)
       }
    
}
