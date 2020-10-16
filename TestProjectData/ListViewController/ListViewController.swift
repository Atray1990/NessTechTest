//
//  ListViewController.swift
//  TestProjectData
//
//  Created by shashank atray on 13/10/20.
//  Copyright © 2020 shashank atray. All rights reserved.
//  LinkeIn - https://www.linkedin.com/in/shashank-k-atray/
//

import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    // lazy var searchBar:UISearchBar = UISearchBar(frame: CGRect(x: 10, y: 5, width: 250, height: 25))
    @IBOutlet weak var searchBar:UISearchBar!
    @IBOutlet weak var saveButton:UIButton!
    
    let tableViewDataSource = TableViewDataSource()
    var eventHandler: ListViewEventHandler!
    
    var testPackage: [TestPackage] = []
    var searchText: String?
    var selectedTestPackage: [TestPackage] = []
    
    // MARK:- lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
         navigationItem.title = "Countries"
        eventHandler.getCoreData()
        selectedTestPackage = []
    }
    
    
    func setUpViews() {
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(popBack))
        navigationItem.title = "Search Package"
        
        searchBar.placeholder = "search image"
        searchBar.delegate = self
        
        self.tableView.dataSource = tableViewDataSource
        self.tableView.reloadData()
    }
    
    func showAlertForEmpty() {
        let alert = UIAlertController(title: "Title", message: "Please Select a test you want to be done.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler:{ (UIAlertAction)in
            print("User click Dismiss button")
        }))
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
    func saveTestData(testData: [TestPackage]) {
        self.testPackage = testData
    }
    
    func showTestData(testData: [TestPackage]) {
        self.tableViewDataSource.testData = testData
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    // MARK:- iboutlet and navigation
    /* not that proficient with Core Data, havnt used in long time hence added another way to manage the data as well.
     */
  
    @objc func popBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func moveToCountryScreen(testData: TestPackage) {
        if let navController = self.navigationController {
            eventHandler.moveToCountryScreen(navController: navController, selectedTest: testData)
        }
    }
    
}
// MARK:- delegates of search bar
extension ListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count < 3 {
            self.showTestData(testData: testPackage)
        } else {
             eventHandler.searchThroughData(testData: testPackage, searchString: searchText)
        }
    }
}

// MARK:- delegates of table view
extension ListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.moveToCountryScreen(testData: testPackage[indexPath.row])
    }    
}

